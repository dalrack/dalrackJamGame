package;
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
	//public var textList:Array<String>; //Array of strings, each string should only be a word for the sentence.
	//public var textFormat:TextFormat;
	public function new() 
	{
		super();
		var textList:Array<String>;
		var textFormat = new TextFormat();
		textFormat.font = "Warnock";
		textFormat.color = 0x000000;
		textFormat.size = 18;
		
		var text = new TextField();
		text.text = "This is a story about your life!";
		text.x = 20;
		text.y = Lib.current.stage.stageHeight - 40;
		text.width = 290;
		
		text.setTextFormat(textFormat);
		Lib.current.stage.addChild(text);
	}
	
	
	
}