using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication5
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var dbContext = new BlogPostDBContainer())
            {
                Blog blog = new Blog();
                blog.BlogName = "Test Blog1";
                dbContext.Blogs.Add(blog);

                Post post = new Post();
                post.Subject = "Test blog post subject 1";
                blog.Posts.Add(post);

                dbContext.SaveChanges();
            }
        }
    }
}
