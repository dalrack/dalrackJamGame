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

class DialogueHandler
{
	public var DialogueList:Array<DialogueString>;
	public var DialoguePosition:Int = 0;
	//private var textHandler:TextHandler;
	public function new() 
	{
		DialogueList = new Array<DialogueString>();
		var dialogueTest1:DialogueString = new DialogueString("This is a story");
		DialogueList.push(dialogueTest1);
		var dialogueTest2:DialogueString = new DialogueString("It is the best story");
		DialogueList.push(dialogueTest2);
		var dialogueTest3:DialogueString = new DialogueString("Now story is as good as this story");
		DialogueList.push(dialogueTest3);
		var dialogueTest4:DialogueString = new DialogueString("In this story you will go through this story");
		DialogueList.push(dialogueTest4);
		var dialogueTest5:DialogueString = new DialogueString("Which is a story");
		DialogueList.push(dialogueTest5);

	}
	
	public function displayNextDialogue()
	{
		if (DialoguePosition < DialogueList.length)
		{
			//Main.getInstance().texthandler.removeText();
			Main.getInstance().texthandler.textFull[0].text = DialogueList[DialoguePosition].thisisastring;
			DialoguePosition++;
		}
	}
}

class DialogueString
{
	public var text:TextField;
	public var thisisastring:String;
	public function new(string:String)
	{
		text = new TextField();
		var textFormat = new TextFormat();
		textFormat.font = "Warnock"; //required text format information
		textFormat.color = 0x000000; //required text format information
		textFormat.size = 16; //required text format information
		text.text = string; //String to be displayed
		thisisastring = string;
		text.x = 20; //x position the text will start
		text.y = Lib.current.stage.stageHeight - 40; //the y position the text will start
		text.width = 290; //the width for our window
		text.setTextFormat(textFormat); //set the text format
	}
}