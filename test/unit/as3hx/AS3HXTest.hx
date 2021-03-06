package as3hx;
import as3hx.Config;
import as3hx.Parser;
import as3hx.Writer;
import haxe.io.BytesOutput;
import massive.munit.Assert;
import sys.FileSystem;
import sys.io.File;

class AS3HXTest {

    public function new() {}
    
    var cfg:as3hx.Config;
    var parser:as3hx.Parser;
    var writer:as3hx.Writer;
    var output:haxe.io.BytesOutput;
    
    @BeforeClass
    public function beforeClass() {
        cfg = new Config();
        parser = new Parser(cfg);
        writer = new Writer(cfg);
        output = new BytesOutput();
    }
    
    @Test
    public function issue14() {
        generate("Issue14.as", "Issue14.hx");
    }
    
    @Test("ternarny operator")
    public function issue28() {
        generate("Issue28.as", "Issue28.hx");
    }
    
    @Test
    public function issue29() {
        generate("Issue29.as", "Issue29.hx");
    }
    
    @Test("array.concat() -> array.copy()")
    public function issue32() {
        generate("Issue32.as", "Issue32.hx");
    }
    
    @Test("string.charCodeAt() -> string.charCodeAt(0)")
    public function issue36() {
        generate("Issue36.as", "Issue36.hx");
    }
    
    @Test("Xml(string) -> FastXML.parse(string)")
    public function issue37() {
        generate("Issue37.as", "Issue37.hx");
    }
    
    @Test
    public function issue38() {
        generate("Issue38.as", "Issue38.hx");
    }
    
    @Test("private var name = 'value'")
    public function issue52() {
        generate("Issue52.as", "Issue52.hx");
    }
    
    @Test("array.length = 10 -> Compat.setArrayLegth(array, 10)")
    public function issue63() {
        generate("Issue63.as", "Issue63.hx");
    }
    
    @Test("for (var i:int = 0, n:int = array.length; i < n; i++)")
    public function issue64() {
        generate("Issue64.as", "Issue64.hx");
    }
    
    @Test
    public function issue65() {
        generate("Issue65.as", "Issue65.hx");
    }
    
    @Test("array.slice() -> array.copy()")
    public function issue68() {
        generate("Issue68.as", "Issue68.hx");
    }
    
    @Test("string.charAt() -> string.charAt(0)")
    public function issue69() {
        generate("Issue69.as", "Issue69.hx");
    }
    
    @Test
    public function issue71() {
        generate("Issue71.as", "Issue71.hx");
    }
    
    @Test
    public function issue81() {
        generate("Issue81.as", "Issue81.hx");
    }
    
    @Test("JSON.parse(string) -> haxe.Json.parse(string)")
    public function issue83() {
        generate("Issue83.as", "Issue83.hx");
    }
    
    @Test("uint(1) -> as3hx.Compat.parseInt(1)")
    public function issue85() {
        generate("Issue85.as", "Issue85.hx");
    }
    
    @Test
    public function issue87() {
        generate("Issue87.as", "Issue87.hx");
    }
    
    @Test("NaN -> Math.NaN")
    public function issue89() {
        generate("Issue89.as", "Issue89.hx");
    }
    
    @Test("var b:Boolean = !int -> var b:Bool = int != 0")
    public function issue91() {
        generate("Issue91.as", "Issue91.hx");
    }
    
    @Test("[].join() -> [].join(',')")
    public function issue93() {
        generate("Issue93.as", "Issue93.hx");
    }
    
    @Test("array.push(1,2,3,4,5,6,7,8,9,0)")
    public function issue94() {
        generate("Issue94.as", "Issue94.hx");
    }
    
    @Test
    public function issue95() {
        generate("Issue95.as", "Issue95.hx");
    }
    
    @Test("s is String ? 1 : 0")
    public function issue96() {
        generate("Issue96.as", "Issue96.hx");
    }
    
    @Test
    public function issue103() {
        generate("Issue103.as", "Issue103.hx");
    }
    
    @Test("setTimeout() -> as3hx.Compat.setTimeout()")
    public function issue112() {
        generate("Issue112.as", "Issue112.hx");
    }
    
    @Test
    public function issue115() {
        generate("Issue115.as", "Issue115.hx");
    }
    
    @Test("delete obj['key']")
    public function issue121() {
        generate("Issue121.as", "Issue121.hx");
    }
    
    function generate(as3FileName:String, expectedHaxeFileName:String) {
        var issuesDirectory = FileSystem.absolutePath("test/issues");
        var generatedDirectoryPath = '$issuesDirectory/generated';
        if (!FileSystem.exists(generatedDirectoryPath)) FileSystem.createDirectory(generatedDirectoryPath);
        var content = File.getContent('$issuesDirectory/$as3FileName');
        var program = parser.parseString(content, issuesDirectory, '$issuesDirectory/$as3FileName');
        var fw = File.write('$generatedDirectoryPath/$expectedHaxeFileName', false);
        writer.process(program, fw);
        fw.close();
        var expectedText = File.getContent('$issuesDirectory/$expectedHaxeFileName');
        var actualText = File.getContent('$generatedDirectoryPath/$expectedHaxeFileName');
        Assert.areEqual(expectedText, actualText);
    }
}