using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

namespace Spacelabs.WaveformSse.Logging
{
    public static class GuidNameRepository
    {
        private static object nameDictLock = new object();
        static private ConcurrentDictionary<Guid, string> GuidNameDict = new ConcurrentDictionary<Guid, string>();

        static public void AddGuidWithName(Guid guid, string name)
        {
            string guid_pattern = @"([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})";
            MatchCollection matches = Regex.Matches(name, guid_pattern);
            if (name.Length > 3 && (matches == null || matches.Count == 0))
            {
                GuidNameDict.AddOrUpdate(guid, name, (k, o) => name);
            }
        }


        static public string ReplaceIdsWithNames(string origString)
        {
            bool dontCare;
            return ReplaceIdsWithNames(origString, out dontCare);
        }

        /// <summary>
        ///         ReplaceIdsWithNames will take a request url containing guid's and replace the guid's with readable
        ///         names based on guid, name mappings added with AddGuidWithName
        ///         Unrecognized guids will remain unaltered.
        /// </summary>
        /// <param name="origString">original request url containing guids</param>
        /// <returns>"friendly" version of url for logging purposes only</returns>
        static public string ReplaceIdsWithNames(string origString, out bool didReplacement)
        {
            didReplacement = false;
            string retval = origString;

            string guid_pattern = @"([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})";
            MatchCollection matches = Regex.Matches(origString, guid_pattern);

            if (matches != null)
            {
                foreach (Match match in matches)
                {
                    string guidString = match.Groups[1].Value;
                    string name = "";
                    Guid guid = new Guid(guidString);
                    for (int i = 0; i < 5; i++)
                    {
                        if (GuidNameDict.TryGetValue(guid, out name))
                        {
                            string replaceText = string.Format("{{{0} <- {1}}}", name, guid);
                            retval = retval.Replace(guidString, replaceText);
                            didReplacement = true;
                            break;
                        }
                    }
                }
            }
            return retval;
        }

        static public string ReplaceIdsWithNamesOnly(string origString)
        {
            bool dontCare;
            return ReplaceIdsWithNamesOnly(origString, out dontCare);
        }

        static public string ReplaceIdsWithNamesOnly(string origString, out bool didReplacement)
        {
            didReplacement = false;
            string retval = origString;

            string guid_pattern = @"([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})";
            MatchCollection matches = Regex.Matches(origString, guid_pattern);

            if (matches != null)
            {
                foreach (Match match in matches)
                {
                    string guidString = match.Groups[1].Value;
                    string name = "";
                    Guid guid = new Guid(guidString);
                    for (int i = 0; i < 5; i++)
                    {
                        if (GuidNameDict.TryGetValue(guid, out name))
                        {
                            string replaceText = string.Format("{0}", name);
                            retval = retval.Replace(guidString, replaceText);
                            didReplacement = true;
                            break;
                        }
                    }
                }
            }
            return retval;
        }

    }
}