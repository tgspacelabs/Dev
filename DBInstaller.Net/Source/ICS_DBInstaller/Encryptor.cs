// ------------------------------------------------------------------------------------------------
// File: Encryptor.cs
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
using System.Globalization;
using System.Text;

namespace Spacelabs.DBInstaller
{
	/// <summary>
	/// Summary description.
	/// </summary>
	public class Encryptor : Object
	{
		private string m_strDefaultKey;
		private string m_strUnicodePrefix;

		public Encryptor()
		{
			m_strDefaultKey = "phepmagi";
			m_strUnicodePrefix = "5753";
		}

		// performs regular encryption
		public string Encrypt(string value, string key)
		{
			string strOut;

            if (string.IsNullOrEmpty(value))
                return string.Empty;

			if (key == null || key.Length == 0)
				key = m_strDefaultKey;

			int nKeyLen = key.Length;
			int nKeyPos = -1;

			Random genRand = new Random(unchecked((int)DateTime.Now.Ticks)); 
			int nOffset = genRand.Next(255);
			strOut = StringUtility.IntToHexString(nOffset, 2);

			int i, nCount;
			nCount = value.Length;
			int nKeyChar;
			for (i = 0; i < nCount; i++)
			{
				int nSrcAscii = (((int) value[i]) + nOffset) % 255;
				if (nKeyPos < nKeyLen - 1)
				{
					nKeyPos++;
					nKeyChar = (int) key[nKeyPos];
				}
				else
				{
					nKeyPos = -1;
					nKeyChar = 0;
				}

				nSrcAscii ^= nKeyChar;
				strOut += StringUtility.IntToHexString(nSrcAscii, 2);
				nOffset = nSrcAscii;
			}

			return strOut;
		}


		// performs unicode encryption
		public string EncryptUnicode(string value, string key)
		{
			string strOut;

            if (string.IsNullOrEmpty(value))
                return string.Empty;

			if (key == null || key.Length == 0)
				key = m_strDefaultKey;

			int nKeyLen = key.Length;
			int nKeyPos = -1;

			Random genRand = new Random(unchecked((int)DateTime.Now.Ticks)); 
			int nOffset = genRand.Next(65535);
			strOut = m_strUnicodePrefix + StringUtility.IntToHexString(nOffset, 4);

			int i, nCount;
			nCount = value.Length;
			int nKeyChar;
			for (i = 0; i < nCount; i++)
			{
				int nSrcAscii = (((int) value[i]) + nOffset) % 65535;
				if (nKeyPos < nKeyLen - 1)
				{
					nKeyPos++;
					nKeyChar = (int) key[nKeyPos];
				}
				else
				{
					nKeyPos = -1;
					nKeyChar = 0;
				}

				nSrcAscii ^= nKeyChar;
				strOut += StringUtility.IntToHexString(nSrcAscii, 4);
				nOffset = nSrcAscii;
			}

			return strOut;
		}

		// performs regular and Unicode decryption
		public string Decrypt(string value, string key)
		{            
			string strOut = "";

            if (!string.IsNullOrEmpty(value))
            {

                if (key == null || key.Length == 0)
                    key = m_strDefaultKey;

                //check the type of decrypt required
                int nCharLength = 2;
                int nMaxOffset = 255;
                if (value.StartsWith(m_strUnicodePrefix, StringComparison.OrdinalIgnoreCase))
                {
                    //set values for Unicode decrypt and remove the Unicode prefix
                    nCharLength = 4;
                    nMaxOffset = 65535;
                    value = value.Remove(0, m_strUnicodePrefix.Length);
                }


                int nSrcPos = nCharLength;
                int nKeyPos = -1;
                string strSrc = value;
                int nSrcLen = strSrc.Length;
                int nKeyLen = key.Length;
                int nSrcAscii = 0;
                int nTmpSrcAscii = 0;

                int nOffset;

                nOffset = int.Parse(value.Substring(0, nCharLength), NumberStyles.HexNumber, CultureInfo.InvariantCulture);

                int nKeyChar;
                do
                {
                    nSrcAscii = int.Parse(strSrc.Substring(nSrcPos, nCharLength), NumberStyles.HexNumber, CultureInfo.InvariantCulture);

                    if (nKeyPos < nKeyLen - 1)
                    {
                        nKeyPos += 1;
                        nKeyChar = (int)key[nKeyPos];
                    }
                    else
                    {
                        nKeyPos = -1;
                        nKeyChar = 0;
                    }

                    nTmpSrcAscii = nSrcAscii ^ nKeyChar;

                    if (nTmpSrcAscii <= nOffset)
                        nTmpSrcAscii += nMaxOffset - nOffset;
                    else
                        nTmpSrcAscii -= nOffset;

                    strOut += (char)nTmpSrcAscii;
                    nOffset = nSrcAscii;
                    nSrcPos += nCharLength;
                } while (nSrcPos < nSrcLen);
            }
			return strOut;
		}
	}
}

