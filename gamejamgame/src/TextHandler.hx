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
	public var dialogue:DialogueHandler;
	private var textPosition:Int = 0;
	
	public function new() 
	{
		super();
		textFull = new Array<TextField>();
		dialogue = new DialogueHandler(); //This breaks shit, I don't konw why
		
		
		/*
		var textFormat = new TextFormat();
		textFormat.font = "Warnock"; //required text format information
		textFormat.color = 0x000000; //required text format information
		textFormat.size = 16; //required text format information
		var text = new TextField();
		text.text = "This is a story about your life!"; //String to be displayed
		text.x = 20; //x position the text will start
		text.y = Lib.current.stage.stageHeight - 40; //the y position the text will start
		text.width = 290; //the width for our window
		text.setTextFormat(textFormat); //set the text format
		textFull.push(text); //push the current text block into the array
		
		Lib.current.stage.addChild(textFull[0]); //add the text to the stage 
		*/
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