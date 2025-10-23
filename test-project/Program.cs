using System;

class BuildTestApp
{
    static int Main(string[] args)
    {
        Console.WriteLine("=== Build Test Application ===");
        Console.WriteLine($"Environment: {GetEnvironment()}");
        Console.WriteLine($"Build Number: {GetBuildNumber()}");
        Console.WriteLine($"Source Branch: {GetSourceBranch()}");
        Console.WriteLine();
        
        if (RunTests())
        {
            Console.WriteLine("✅ All checks passed!");
            return 0;
        }
        else
        {
            Console.WriteLine("❌ Tests failed!");
            return 1;
        }
    }

    static bool RunTests()
    {
        bool passed = true;

        // Check 1: Basic math
        if (Add(2, 2) != 4)
        {
            Console.WriteLine("❌ Math test failed");
            passed = false;
        }
        else
        {
            Console.WriteLine("✅ Math test passed");
        }

        // Check 2: String operations
        if (!Greet("Pipeline").Contains("Pipeline"))
        {
            Console.WriteLine("❌ String test failed");
            passed = false;
        }
        else
        {
            Console.WriteLine("✅ String test passed");
        }

        // Check 3: Environment variable (set by pipeline)
        string agentName = Environment.GetEnvironmentVariable("AGENT_NAME");
        if (string.IsNullOrEmpty(agentName))
        {
            Console.WriteLine("⚠️  Agent name not set (expected in pipeline context)");
        }
        else
        {
            Console.WriteLine($"✅ Running on agent: {agentName}");
        }

        return passed;
    }

    static int Add(int a, int b) => a + b;
    
    static string Greet(string name) => $"Hello, {name}!";
    
    static string GetEnvironment() => Environment.GetEnvironmentVariable("BUILD_ENV") ?? "local";
    
    static string GetBuildNumber() => Environment.GetEnvironmentVariable("BUILD_BUILDNUMBER") ?? "local-build";
    
    static string GetSourceBranch() => Environment.GetEnvironmentVariable("BUILD_SOURCEBRANCH") ?? "unknown";
}
