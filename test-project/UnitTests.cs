using Xunit;

public class BuildTestAppTests
{
    [Fact]
    public void Add_TwoNumbers_ReturnsSum()
    {
        // Arrange
        int a = 5;
        int b = 3;

        // Act
        var result = SimpleAdd(a, b);

        // Assert
        Assert.Equal(8, result);
    }

    [Fact]
    public void Greet_WithName_ReturnsGreeting()
    {
        // Arrange
        string name = "World";

        // Act
        var result = SimpleGreet(name);

        // Assert
        Assert.Contains("World", result);
    }

    [Fact]
    public void Greet_WithPipeline_ReturnsCorrectMessage()
    {
        // Arrange
        string name = "Pipeline";

        // Act
        var result = SimpleGreet(name);

        // Assert
        Assert.Equal("Hello, Pipeline!", result);
    }

    // Helper methods (mirror of main app)
    private int SimpleAdd(int a, int b) => a + b;
    private string SimpleGreet(string name) => $"Hello, {name}!";
}
