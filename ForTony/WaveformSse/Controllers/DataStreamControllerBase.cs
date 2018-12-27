using System;
using System.Configuration;
using System.IO;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Threading;
using System.Web;
using System.Web.Http;

//using Metrics;
//using Spacelabs.SLNI.MetricReporting;
//using Spacelabs.SLNI.WebAPI.Converters;
using Spacelabs.WaveformSse.Logging;
using Spacelabs.XNetDataContracts;

namespace Spacelabs.WaveformSse.Controllers
{
    /// <inheritdoc />
    /// <summary>
    /// DataStreamControllerBase encapsulates the stream handling responsibilities
    /// of XprezzNet's stream output controllers
    /// </summary>
    /// <typeparam name="TInPacketType">Data Type of packets to be output</typeparam>
    public class DataStreamControllerBase<TInPacketType> : ApiController
    {
        private readonly string _writeCounterContext;
        /// <summary>
        /// DefaultMaxOutputQueueSize
        /// </summary>
        protected const int DefaultMaxOutputQueueSize = 2000;
        /// <summary>
        /// DefaultMaxOutputQueueSize
        /// </summary>
        protected const int ConnectionCancelledByRemoteExCode = unchecked((int)0x800704CD);

        /// <summary>
        /// Logger
        /// </summary>
        protected ILogger Logger;
        /// <summary>
        /// RequestLogger
        /// </summary>
        protected ILogger RequestLogger;
        /// <summary>
        /// ResponseLogger
        /// </summary>
        protected ILogger ResponseLogger;
        /// <summary>
        /// ApiExceptLogger
        /// </summary>
        protected ILogger ApiExceptLogger;

        //private ClientConnection _connection;
        /// <summary>
        /// 
        /// </summary>
        protected bool Canceled;

        /// <summary>
        /// CombinedCancellationToken - Combination of CancellationToken passed to Api and locally controlled CancellationToken
        /// </summary>
        protected CancellationToken CombinedCancellationToken;

        /// <summary>
        /// ChildCancellationTokenSource - gets combined with api call's CancellationToken to create a composite CancellationToken
        /// </summary>
        protected CancellationTokenSource ChildCancellationTokenSource = new CancellationTokenSource();

        ///// <summary>
        ///// StreamExceptions - Metric
        ///// </summary>
        //protected Counter StreamExceptions;
        ///// <summary>
        ///// StreamCancelled - Metric
        ///// </summary>
        //protected Counter StreamCancelled;
        ///// <summary>
        ///// StreamOverflow - Metric
        ///// </summary>
        //protected Counter StreamOverflow;
        ///// <summary>
        ///// StreamWrites - Metric
        ///// </summary>
        //protected Counter StreamWrites;
        ///// <summary>
        ///// Requests - Metric
        ///// </summary>
        //protected Counter Requests;

        /// <summary>
        /// PrereqChecker - PrerequisiteChecker
        /// </summary>
        //internal PrerequisiteChecker PrereqChecker = new PrerequisiteChecker();


        private bool _disposed;
        /// <summary>
        /// Instance - Identifies which instance of this controller
        ///            This will be instance of controllers of type TInpacketType
        /// </summary>
        // ReSharper disable once StaticMemberInGenericType
        protected static long Instance;

        /// <summary>
        /// MaxQueueSize - For metrics. This holds the largest number of entries we have seen in the queue
        /// </summary>
        protected double? MaxQueueSize = null;
        /// <summary>
        /// JsonStreamFormatter - we initialize the Json formatter to our requirements for output
        /// </summary>
        protected JsonMediaTypeFormatter JsonStreamFormatter;

        /// <summary>
        /// BlockingQueueSize - All stream controllers have a queue of items to be output.
        /// the size defaults to 2000 but may overriden with Configuration Parameter "MaxAlertStreamOutputQueueSize"
        /// </summary>
        protected Int32 BlockingQueueSize = 2000;

        /// <summary>
        /// DataType - Used for logging and metrics
        /// </summary>
        protected string DataType;

        /// <summary>
        /// FullDataFeedName - Used for logging and metrics
        /// </summary>
        protected string FullDataFeedName = "UnitializedDataFeedName"; // Should be initialized by derived class

        /// <summary>
        /// FriendlyDataFeedName - Used for logging and metrics
        /// </summary>
        protected string FriendlyDataFeedName = "UnitializedDataFeedName"; // Should be initialized by derived class


        /// <inheritdoc />
        /// <summary>
        /// WaveformSSEController constructor
        /// </summary>
        public DataStreamControllerBase(string dataType)
        {
            DataType = dataType;
            //JsonStreamFormatter = JsonUtilities.CreateSLJsonFormatter($"Json.{DataType}.");
            JsonStreamFormatter = new JsonMediaTypeFormatter();
            Instance++;
            InitializeLoggers();
            InitializeMetrics();
            Logger.Log(LogLevel.DEBUG, "ctor");
            _writeCounterContext = $"{DataType}WrittenToStream {Instance}";
        }

        /// <inheritdoc />
        /// <summary>
        /// IDispose implementation
        /// </summary>
        protected override void Dispose(bool disposing)
        {
            if (_disposed)
                return;

            if (disposing)
            {
                //MetricsAccess.Instance.ShutdownSubContext("WebAPI", _writeCounterContext);
                CleanupConnections();
            }

            // Free any unmanaged objects here.
            //

            _disposed = true;
            // Call base class implementation.
            base.Dispose(disposing);
        }

        /// <summary>
        /// InitializeLoggers
        /// </summary>
        private void InitializeLoggers()
        {
            Logger = Logging.Logger.CreateLogger("SLNI.WebAPI");
            RequestLogger = Logging.Logger.CreateLogger("SLNI.WebAPI.Request");
            ResponseLogger = Logging.Logger.CreateLogger("SLNI.WebAPI.Response");
            ApiExceptLogger = Logging.Logger.CreateLogger("SLNI.WebAPI.Exceptions");
        }

        /// <summary>
        /// InitializeMetrics
        /// </summary>
        private void InitializeMetrics()
        {
            //StreamExceptions = CdiHostService.Instance.MetricsAccessor.CounterAccess("WebAPI", $"{DataType}Exceptions", Unit.Events);
            //StreamCancelled = CdiHostService.Instance.MetricsAccessor.CounterAccess("WebAPI", $"{DataType}CancelledByRemote", Unit.Events);
            //StreamOverflow = CdiHostService.Instance.MetricsAccessor.CounterAccess("WebAPI", $"{DataType}StreamOverflow", Unit.Events);
            //StreamWrites = CdiHostService.Instance.MetricsAccessor.CounterAccess("WebAPI", $"PacketsWrittenTo{DataType}Stream", Unit.Events);
            //Requests = CdiHostService.Instance.MetricsAccessor.CounterAccess("WebAPI", "Requests", Unit.Events);
        }

        /// <summary>
        /// InitializeFeeds - Implemented by derived classes to Initialize data feeds
        /// </summary>
        protected virtual void InitializeFeeds()
        {
        }


        /// <summary>
        /// GetUpdatesInternal - Invoked by derived classes to provided encapuslated stream handling
        /// </summary>
        /// <param name="requestCancellationToken">The cancellation token passed to invoker's GetUpdates call</param>
        /// <returns></returns>
        protected HttpResponseMessage GetUpdatesInternal(CancellationToken requestCancellationToken)
        {

            ChildCancellationTokenSource = CancellationTokenSource.CreateLinkedTokenSource(requestCancellationToken);
            CombinedCancellationToken = ChildCancellationTokenSource.Token;

            RequestLogger.Log(LogLevel.INFO,
                $"Request for {DataType} {FriendlyDataFeedName}: {Request.RequestUri}");
            //Requests.Increment($"{DataType}");




            // Check prerequisites

            //PrereqChecker.ThrowIfUnlicensed(this);
            //PrereqChecker.ThrowIfCdiInitializeError(this);
            //PrereqChecker.ThrowIfUnhealthy(XNStatus.Yellow);

            // Register this connection with the ClientTracker

            var clientIp = ((HttpContextBase)Request.Properties["MS_HttpContext"]).Request.UserHostAddress;
            var clientRequest = Request.RequestUri.ToString();
            //clientRequest = GuidNameRepository.ReplaceIdsWithNames(clientRequest);
            //_connection = new ClientConnection(clientIp, $"{DataType}", clientRequest);
            //CdiHostService.Instance.ClientTracker.Add(_connection);

            BlockingQueueSize = DefaultMaxOutputQueueSize;
            var queueCfgSetting = ConfigurationManager.AppSettings["MaxAlertStreamOutputQueueSize"];
            if (!string.IsNullOrEmpty(queueCfgSetting))
            {
                int.TryParse(queueCfgSetting, out BlockingQueueSize);
            }

            InitializeFeeds();




            // Create a response object
            var response = Request.CreateResponse();

            // The PushStreamContext creates a context which gets returned to web client
            // The lamda expression is invoked which will loop to format and output output the data
            response.Content = new PushStreamContent(

                // This lambda expression executes AFTER the created stream content has been returned
                (outputStream, httpContent, transportContext) =>
                {
                    try
                    {
                        using (StreamWriter writer = new StreamWriter(outputStream))
                        {
                            // Register a callback which gets triggered when a client disconnects
                            requestCancellationToken.Register(HandleConnectionClosedByRemote, this);

                            var firstPacket = true;

                            while (!Canceled)
                            {
                                var outPacket = NextPacket(CombinedCancellationToken);
                                if (CombinedCancellationToken.IsCancellationRequested)
                                {
                                    HandleConnectionClosedByRemote(this);
                                }
                                else if (OutputQueueOverflow())
                                {
                                    HandleOverflowCondition();
                                }
                                else
                                {
                                    try
                                    {


                                        // Collect metrics on how long it takes to actually output the data
                                        // This will increase if the client is not reading the data in a timely fashion
                                        //using (CdiHostService.Instance.MetricsAccessor.TimerAccess($"{DataType}WriteToStream", "", Unit.Requests).NewContext())
                                        {
                                            WritePacketToStream(outPacket, outputStream, writer, firstPacket);
                                            firstPacket = false;
                                            //CdiHostService.Instance.MetricsAccessor.CounterAccess("WebAPI", $"PacketsWrittenTo{DataType}Stream", Unit.Events).Increment(1);
                                        }
                                    }
                                    catch (HttpException ex)
                                    {
                                        if (ex.ErrorCode == ConnectionCancelledByRemoteExCode || CombinedCancellationToken.IsCancellationRequested) // The remote host closed the _connection. 
                                        {
                                            HandleConnectionClosedByRemote(ex);
                                        }
                                        else
                                        {
                                            HandleHttpException(ex);
                                        }
                                    }
                                    catch (Exception ex)
                                    {
                                        if (CombinedCancellationToken.IsCancellationRequested) // The remote host closed the _connection. 
                                        {
                                            HandleConnectionClosedByRemote(ex);
                                        }
                                        else
                                        {
                                            HandleExceptionInOutputLoop(ex);
                                        }
                                    }
                                }


                            }
                        }

                    }
                    catch (HttpException ex)
                    {
                        if (ex.ErrorCode == ConnectionCancelledByRemoteExCode || CombinedCancellationToken.IsCancellationRequested) // The remote host closed the _connection. 
                        {
                            HandleConnectionClosedByRemote(ex);
                        }
                        else
                        {
                            HandleHttpException(ex);
                        }
                    }
                    finally
                    {
                        CleanupConnections();
                    }

                }, "text/event-stream");



            return response;
        }

        /// <summary>
        /// NextPacket - To be overriden by derived classes - returns next packet to output
        /// </summary>
        /// <param name="ct"></param>
        /// <returns></returns>
        protected virtual TInPacketType NextPacket(CancellationToken ct)
        {
            return default(TInPacketType);
        }

        /// <summary>
        /// OutputQueueOverflow - To be overriden by derived classes - returns whether Queue is in overflow state
        /// </summary>
        /// <returns></returns>
        protected virtual bool OutputQueueOverflow()
        {
            return false;
        }


        /// <summary>
        /// WritePacketToStream - To be overriden by derived classes - Performs actual output of packet to stream
        /// </summary>
        /// <param name="packet"></param>
        /// <param name="stream"></param>
        /// <param name="sw"></param>
        /// <param name="isFirstPacket"></param>
        protected virtual void WritePacketToStream(TInPacketType packet, Stream stream, StreamWriter sw, bool isFirstPacket = false)
        {
            //CdiHostService.Instance.MetricsAccessor.CounterAccess("WebAPI", _writeCounterContext, Metrics.Unit.Events).Increment(1);

        }
        private void HandleExceptionInOutputLoop(Exception ex)
        {
            Logger.Log(LogLevel.EXCEPTION, "Unexpected Exception in WaveStream Output loop {0} {1} ", Request.RequestUri.ToString(), ex.ToString());
            Canceled = true;
            ChildCancellationTokenSource.Cancel();
            CleanupConnections();
        }

        private void HandleConnectionClosedByRemote(object param)
        {
            if (Canceled) return;

            ChildCancellationTokenSource.Cancel();
            //StreamCancelled.Increment();
            ResponseLogger.Log(LogLevel.INFO, $"{DataType} {FullDataFeedName} CANCELED by client");
            Canceled = true;
            CleanupConnections();
        }

        private void HandleHttpException(HttpException ex)
        {
            if (!Canceled)
            {
                // Sometimes the RemoteHostClosed Connection exception will
                // come through as a HttpException
                if (ex.InnerException?.HResult != null)
                {
                    var hresult = (uint)ex.InnerException?.HResult;
                    if (hresult == 0x800704cd)
                    {
                        RequestLogger.Log(LogLevel.INFO, "HttpException 0x800704cd handling as ConnectionClosedByRemote");
                        HandleConnectionClosedByRemote(this);
                    }
                    else
                    {
                        //StreamExceptions.Increment();
                        ApiExceptLogger.Log(LogLevel.EXCEPTION, $"Http exception {ex} Inner exception HResult {ex.InnerException?.HResult}");
                        ChildCancellationTokenSource.Cancel();
                        Canceled = true;
                        CleanupConnections();
                    }
                }
            }
        }

        private void HandleOverflowCondition()
        {
            Canceled = true;
            ChildCancellationTokenSource.Cancel();
            //StreamOverflow.Increment();
            Logger.Log(LogLevel.ERROR, "Output queue overflow. Did web client stop reading??? {0}", Request.RequestUri.ToString());
            CleanupConnections();
        }


        private void CleanupConnections()
        {
            try
            {
                StopDataFeeds();
            }
            catch
            {
                ResponseLogger.Log(LogLevel.EXCEPTION, "Exception detaching from WaveformDataArrived Event {0}", Request.RequestUri.ToString());
            }
            //CdiHostService.Instance.ClientTracker.Remove(_connection);
        }

        /// <summary>
        /// StopDataFeeds - Implemented by derived classes to teardown data feeds
        /// </summary>
        protected virtual void StopDataFeeds()
        {

        }

    }
}

