package;
import flash.display.DisplayObject;
import flash.Lib;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

/**
 * Class handles requests to print text strings to a certain location in the window
 * @author Zachary Wade
 */

class TextHandler extends Main
{
	public var textFull:Array<TextField>; //Array of strings, each string should only be a word for the sentence.
	public var textCurrent:Array<TextField>;
	public var testSwitch:Bool = true;
	private var textPosition:Int = 0;
	
	public function new() 
	{
		super();
		textFull = new Array<TextField>();
		var textFormat = new TextFormat();
		textFormat.font = "Warnock";
		textFormat.color = 0x000000;
		textFormat.size = 16;
		var text = new TextField();
		text.text = "This is a story about your life!";
		text.x = 20;
		text.y = Lib.current.stage.stageHeight - 40;
		text.width = 290;
		text.setTextFormat(textFormat);
		textFull.push(text);
		

		Lib.current.stage.addChild(textFull[0]);
	}
	
	public function removeText()
	{
		Lib.current.stage.removeChild(textFull[0]);
		textFull.pop();
	}
	
	public function displayText(inputText:TextField)
	{
		textFull.push(inputText);
		Lib.current.stage.addChild(inputText);
	}
}