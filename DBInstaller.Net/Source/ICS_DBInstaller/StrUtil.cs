// ------------------------------------------------------------------------------------------------
// File: StrUtil.cs
// © Copyright 2013 Spacelabs Healthcare, Inc.
//
// This document contains proprietary trade secret and confidential information
// which is the property of Spacelabs Healthcare, Inc.  This document and the
// information it contains are not to be copied, distributed, disclosed to others,
// or used in any manner outside of Spacelabs Healthcare, Inc. without the prior
// written approval of Spacelabs Healthcare, Inc.
// ------------------------------------------------------------------------------------------------
//
using System;
using System.Text;
using System.Globalization;

namespace Spacelabs.DBInstaller
{
    /// <summary>
    /// Summary description.
    /// </summary>
    public static class StringUtility : Object
    {
        /// <summary>
        /// Converts the given string to byte array
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static byte [] StringToByteArray(string value)
        {
            if (string.IsNullOrEmpty(value))
                return null;

            int nLen = value.Length;
            if (nLen == 0)
                return null;

            byte [] aryReturn = new byte [nLen];
            for (int i = 0; i < nLen; i++)
                aryReturn[i] = (byte) value[i];

            return aryReturn;
        }
        /// <summary>
        /// converts the given byte array of specified length to string
        /// </summary>
        /// <param name="value"></param>
        /// <param name="length"></param>
        /// <returns></returns>
        public static string ByteArrayToString(byte [] value, int length)
        {
            if (value == null)
                return string.Empty;

            StringBuilder sb = new StringBuilder();
            for (int i = 0; value[i] != 0 && i < length; i++)
                sb.Append((char) value[i]);
            return sb.ToString();
        }
        /// <summary>
        /// Converts the byte array to string
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static string ByteArrayToString(byte [] value)
        {
            if (value == null)
                return string.Empty;
            else
            return ByteArrayToString(value, value.Length);
        }
        /// <summary>
        /// Converts byte array to hex string
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static string ByteArrayToHexString(byte [] value)
        {
            if (value == null)
                return string.Empty;

            string strReturn = "";
            for (int i = 0; i < value.Length; i++)
            {
                if (value[i] <= 0x0f)
                    strReturn += "0";
                strReturn += value[i].ToString("x", CultureInfo.InvariantCulture);
            }
            return strReturn;
        }
        /// <summary>
        /// Converts the given hex string to byte array
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static byte [] HexStringToByteArray(string value)
        {
            if (string.IsNullOrEmpty(value))
                return null;

            if ((value.Length % 2) != 0)
            {
                ArgumentException e = new ArgumentException("hex string must be of even number of elements");
                throw e;
            }
            byte [] nBytesOut = new byte [value.Length / 2];
            for (int i = 0, j = 0; i < value.Length; i += 2)
                nBytesOut[j++] = byte.Parse(value.Substring(i, 2), NumberStyles.HexNumber, CultureInfo.InvariantCulture);
            return nBytesOut;
        }
        /// <summary>
        /// Converts the array to comma delimited string
        /// </summary>
        /// <param name="array"></param>
        /// <returns></returns>
        public static string ArrayToCommaDelString(Array array)
        {
            string strReturn = "";
            if (array == null)
                return string.Empty;

            for (int i = 0; i < array.Length; i++)
                strReturn += array.GetValue(i).ToString() + ",";
            return strReturn.Substring(0, strReturn.Length - 1);
        }
        /// <summary>
        /// Converts integer to hex string
        /// </summary>
        /// <param name="value"></param>
        /// <param name="width"></param>
        /// <returns></returns>
        public static string IntToHexString(int value, int width)
        {
            string strReturn = "";
            string strHex = value.ToString("x", CultureInfo.InvariantCulture);
            while (width-- > strHex.Length)
                strReturn += "0";
            strReturn += strHex;
            return strReturn;
        }
    }
}

