using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Runtime.Serialization;
using Newtonsoft.Json;

namespace Spacelabs.XNetDataContracts
{
    public class XnGlobalConstants
    {
        // The XprezzNet rest interface provides waveform data (SSE) with timestamps
        // in ms since 1 Jan 1970
        public static readonly DateTime SLOriginTime = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
    }

    [DataContract]
    public class XNDeviceInfo
    {
        [JsonConstructor]
        public XNDeviceInfo(Guid id, string name, bool active, string status, string monitoringStatus, IDictionary<string, object> properties)
        {
            Id = id;
            Name = name;
            Active = active;
            Status = status;
            MonitoringStatus = monitoringStatus;
            Properties = properties.ToDictionary(pair => pair.Key, pair => pair.Value);
            Properties["AcquiredTimeUTC"] = DateTime.Now.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss.fff", CultureInfo.InvariantCulture);
        }

        public XNDeviceInfo(Guid id)
            : this(id, "Unknown", false, "Unknown", "Unknown", new Dictionary<string, object>())
        {
        }
        public XNDeviceInfo()
        {
        }

        public XNDeviceInfo(XNDeviceInfo other)
            : this(other.Id, other.Name, other.Active, other.Status, other.MonitoringStatus, other.Properties)
        {
        }
        [DataMember]
        public bool Active { get; private set; }

        [DataMember]
        public Guid Id { get; private set; }
        [DataMember]
        public string MonitoringStatus { get; internal set; }

        [DataMember]
        public string Name { get; private set; }

        [DataMember]
        public Dictionary<string, object> Properties { get; internal set; }

        [DataMember]
        public string Status { get; internal set; }

    }

    public enum SalishTopicStatusValue
    {
        Valid,
        Invalid
    }

    [DataContract]
    public class XNTopicInfo : IDisposable
    {
        public XNTopicInfo()
        {
            Id = Guid.Empty;
            Name = "Unknown";
            DeviceId = Guid.Empty;
            Type = "Unknown";
            Status = SalishTopicStatusValue.Invalid;
            ModuleInfo = new Dictionary<string, object>();
        }
        public XNTopicInfo(Guid id, string name, Guid deviceId, string type)
            : this()
        {
            Id = id;
            Name = name;
            DeviceId = deviceId;
            Type = type;
            Status = SalishTopicStatusValue.Valid;
        }
        public XNTopicInfo(Guid id, string name, Guid deviceId, string type, IDictionary<string, object> properties)
            : this(id, name, deviceId, type)
        {
            ModuleInfo = properties.ToDictionary(pair => pair.Key, pair => pair.Value);
        }

        public XNTopicInfo(XNTopicInfo src)
            : this(src.Id, src.Name, src.DeviceId, src.Type, src.ModuleInfo)
        {
        }

        [DataMember]
        public Guid Id { get; set; }

        [DataMember]
        public SalishTopicStatusValue Status { get; set; }
        [DataMember]
        public string Name { get; set; }

        [DataMember]
        public Guid DeviceId { get; set; }

        [DataMember]
        public string Type { get; set; }
        [DataMember]
        public IDictionary<string, object> ModuleInfo { get; internal set; }
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        private bool _disposed = false;
        protected virtual void Dispose(bool disposing)
        {
            if (_disposed)
            {
                return;
            }
            if (disposing)
            {

            }
            _disposed = true;
        }

        ~XNTopicInfo()
        {
            Dispose(false);
        }
    }

    [DataContract]
    public class XNFeedInfo
    {
        public XNFeedInfo()
        {
            Id = Guid.Empty;
            Name = "Unknown";
            DeviceId = Guid.Empty;
            TopicId = Guid.Empty;
            Type = "Unkown";
        }
        public XNFeedInfo(Guid id, string name, string type, Guid topicId, Guid deviceId)
        {
            Id = id;
            Name = name;
            DeviceId = deviceId;
            TopicId = topicId;
            Type = type;
        }

        public XNFeedInfo(XNFeedInfo other)
            : this(other.Id, other.Name, other.Type, other.DeviceId, other.TopicId)
        {

        }
        [DataMember]
        public Guid Id { get; private set; }

        [DataMember]
        public string Name { get; private set; }

        [DataMember]
        public Guid DeviceId { get; private set; }

        [DataMember]
        public Guid TopicId { get; private set; }

        [DataMember]
        public string Type { get; private set; }
    }

    [DataContract]
    public class XNPatientInfo
    {
        public XNPatientInfo()
        {
            Id = Guid.Empty.ToString();
            PatientInfo = new Dictionary<string, string>();
        }
        public XNPatientInfo(string id, IDictionary<string, string> patientInfo)
        {
            Id = id;
            PatientInfo = patientInfo;
        }

        public XNPatientInfo(XNPatientInfo other)
            : this(other.Id, other.PatientInfo)
        {
        }

        [DataMember]
        public string Id { get; private set; }

        [DataMember]
        public IDictionary<string, string> PatientInfo { get; private set; }

    }

    [DataContract]


    // uslUINT16 maps to Managed type UInt16
    // uslINT16  maps to Managed type Int16
    // uslUINT32 maps to Managed type UInt32
    // uslINT32  maps to Managed type Int32
    // uslUINT64 maps to Managed type UInt64
    // uslINT64  maps to Managed type Int64
    // uslFLOAT  maps to Managed type float
    // uslDOUBLE maps to Managed type double
    // uslBYTE   maps to Managed type byte
    // uslBOOL   maps to Managed type bool
    // uslUTC    maps to Managed type DateTime

    /// <summary>
    /// 32bit value that contains a single signed sample value with up to 16bits of resolution and
    /// additional option flags.
    /// </summary>

    public class WaveformSample
    {
        /// <summary>
        /// The signed 32 bit sample value.
        /// </summary>
        [DataMember]
        public ushort Value;

        /// <summary>
        /// The signed 32 bit sample value.
        /// </summary>
        [DataMember]
        public ushort Flags;
        /// <summary>
        /// 64Bit value continuous seq No.
        /// </summary>
        [DataMember]
        public long Seq;

        /// <summary>
        /// 64Bit value timestamp in miniseconds since 12:00:00 midnight, January 1, 0001 (0:00:00 UTC on January 1, 0001, in the Gregorian calendar)
        /// </summary>
        [DataMember]
        public long Clock;


        /// <summary>
        /// Is a valid sample
        /// </summary>
        [DataMember]
        public bool IsValid;
        /// <summary>
        /// Construct a Waveform sample from a 32bit raw value.
        /// </summary>
        /// <param name="raw">32 bit raw data of a waveform sample; Left channel(16bits) contains flags, right channel contains 16-bit sample value</param>
        /// <param clock>64 bit timestamp in ticks; Will be transfered to ms internally</Param>
        /// <param seq>64 bit sequence number of waveform samples </param>      
        public WaveformSample(UInt32 value, long clock, long seq)
        {
            Clock = clock;

            Seq = seq;

            Value = (ushort)(value & 0x0000ffff);

            Flags = (ushort)(value >> 16);

            IsValid = (value & 0x40000000) > 0 ? true : false;
        }
    };



    [DataContract]
    public class ClientConnection
    {
        public ClientConnection(string clientIP, string clientType, string clientRequestUri = "")
        {
            ClientType = clientType;
            ClientIP = clientIP;
            ClientRequestUri = clientRequestUri;
            Id = Guid.NewGuid();
        }

        public override bool Equals(System.Object obj)
        {
            // If parameter cannot be cast to ClientConnection return false:
            ClientConnection temp = obj as ClientConnection;
            if ((object)temp == null)
            {
                return false;
            }

            // Return true if the fields match:
            return base.Equals(temp);
        }

        public override int GetHashCode()
        {
            return Id.GetHashCode();
        }

        public bool Equals(ClientConnection connection)
        {
            // If parameter is null return false:
            if ((object)connection == null)
            {
                return false;
            }

            // Return true if the fields match:
            return Id == connection.Id;
        }

        [DataMember]
        public Guid Id { get; private set; }
        [DataMember]
        public string ClientType { get; private set; }


        [DataMember]
        public string ClientIP { get; private set; }

        [DataMember]
        public string ClientRequestUri { get; private set; }
    }

    [DataContract]
    public class VersionInfo
    {
        public VersionInfo(string productId, string serviceVersion)

        {
            ServiceVersion = serviceVersion;
            ProductId = productId;
        }

        public override bool Equals(Object obj)
        {
            // If parameter cannot be cast to ClientConnection return false:
            var temp = obj as VersionInfo;
            return (object)temp != null && base.Equals(temp);

            // Return true if the fields match:
        }

        public override int GetHashCode()
        {
            return ServiceVersion.GetHashCode() + ProductId.GetHashCode();
        }

        public bool Equals(VersionInfo obj)
        {
            // If parameter is null return false:
            if ((object)obj == null)
            {
                return false;
            }

            // Return true if the fields match:
            return (ServiceVersion == obj.ServiceVersion) && (ProductId == obj.ProductId);
        }


        [DataMember]
        public string ServiceVersion { get; private set; }

        [DataMember]
        public string ProductId { get; private set; }
    }

    public enum XNStatus
    {
        Green, // Healthy - All Requests allowed
        Yellow, // Overloaded - Streaming requests not allowed
        Red,     // Critically overloaded - Only status requests allowed
        Orange, // Critical configuration Issue
        Purple  // No Valid License
    }

    [DataContract]
    public class XNStatusResult
    {
        [IgnoreDataMember]
        public XNStatus XnStatus { get; private set; }
        [DataMember]
        public string Status { get; private set; }
        [DataMember]
        public string Message { get; private set; }
        public XNStatusResult(XNStatus status, string message = "")
        {
            XnStatus = status;
            Status = XnStatus.ToString();
            Message = message;
        }
    }


}