using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EmbeddedProperty
{
    //    class CustomAttribute
    //    {
    //    }
    //}

    [AttributeUsage(AttributeTargets.Assembly)]
    public class MyCustomAttribute : Attribute
    {
        string someText;
        public MyCustomAttribute() : this(string.Empty) { }
        public MyCustomAttribute(string txt) { someText = txt; }
        //...
    }

    [AttributeUsage(AttributeTargets.Assembly)]
    public class AssemblyAttribute : Attribute
    {
        string name = "assembly attribute";
    }
}
