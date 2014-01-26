package ;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Matrix;
import flash.geom.Transform;
import flash.Lib;
import openfl.Assets;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFieldType;
/**
 * ...
 * @author jesus
 */

class Main extends Sprite 
{
	var inited:Bool;

	var player:Player ;
	var curLevel:Level;
	
	var mLeft:Bool=false;
	var mRight:Bool = false;
	
	public var texthandler:TextHandler;
	
	var editor:Bool = true;
	
	var drag:Sprite;
	var createAnObject:TextField;
	var createAnObjectSubmit:Sprite;
	
	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;
		player = new Player("player");
		curLevel = new Level(1);
		texthandler = new TextHandler();
		// (your code here)
		
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
		
		addChild(curLevel.spriteList);
		
		addChild(player.display);
		player.display.x = stage.stageWidth / 2 + player.display.width / 2;
		player.display.y = stage.stageHeight - player.display.height-20;
		player.screenOff.x = player.display.x;
		player.screenOff.y = player.display.y;
		player.setDirection(false);
		
		addEventListener(Event.ENTER_FRAME, update);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		
		if (editor) {
			stage.addEventListener(MouseEvent.MOUSE_DOWN, emd);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, emm);
			stage.addEventListener(MouseEvent.MOUSE_UP, emu);
			
			
			createAnObject = new TextField();
			createAnObject.text = "player";
			createAnObject.x = 500;
			createAnObject.selectable = true;
			createAnObject.type = TextFieldType.INPUT;
			createAnObject.autoSize = TextFieldAutoSize.LEFT;
			addChild(createAnObject);
			createAnObjectSubmit = new Sprite();
			createAnObjectSubmit.graphics.beginFill(0xff);
			createAnObjectSubmit.graphics.drawRect(0, 0, 20, 20);
			createAnObjectSubmit.x = createAnObject.x - createAnObjectSubmit.width - 5;
			addChild(createAnObjectSubmit);
			createAnObjectSubmit.addEventListener(MouseEvent.CLICK, createAnObjectClick);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,editorKeys);
		}
	}

	/* SETUP */
	public static var mInstance:Main;
	public static function getInstance():Main {
		return mInstance;
	}
	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
		mInstance = this;
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
		
	}
	
	public function editorKeys(e:KeyboardEvent):Void {
	//	trace(e.keyCode);
		if (e.keyCode == 187) {//+
			var p:Player=curLevel.findEntity(drag);
			p.setDirection(!p.facing);
		}
		else if (e.keyCode == 46) {//delete
			curLevel.removeEntity(drag);
			drag = null;
		}
		#if windows
		else if (e.keyCode >=48 && e.keyCode<=58 ) {
			var level:Int = e.keyCode-48;
			curLevel.save(true,level);
		}
		#end
	}
	public function keyDown(e:KeyboardEvent):Void {
		if (e.keyCode == 87) {//w

		}
		else if (e.keyCode == 65) {//a
			mLeft = true;
			//player.pos.x+=player.movespeed;
		}
		else if (e.keyCode == 83) {//s
			
		}
		else if (e.keyCode == 68) {//d
			mRight = true;
		//	player.pos.x-=player.movespeed;	
		}
		
		
	}
	
	public function keyUp(e:KeyboardEvent):Void {
		if (e.keyCode == 87) {//w
			texthandler.dialogue.displayNextDialogue();
		}
		else if (e.keyCode == 65) {//a
			mLeft = false;
			player.pos.x = curLevel.spriteList.x;
			player.currAnim="stand";
		}
		else if (e.keyCode == 83) {//s
			
		}
		else if (e.keyCode == 68) {//d
			mRight = false;
			player.pos.x = curLevel.spriteList.x;	
			player.currAnim="stand";
		}
	}
	
	public function update(e:Event):Void {
		if (mLeft) {
			if (player.pos.x<=-10)
				player.pos.x += player.movespeed;
			else player.pos.x = curLevel.spriteList.x;
			player.setDirection(true);
		}
		if (mRight) {
			
			if (player.pos.x>=-curLevel.spriteList.width+stage.stageWidth+10)
				player.pos.x -= player.movespeed;
			else player.pos.x = curLevel.spriteList.x;
			player.setDirection(false);
		}
		if (mLeft || mRight) player.currAnim = "walk";
		if (Math.abs(curLevel.spriteList.x-player.pos.x)>.1){
			curLevel.spriteList.x += (player.pos.x - curLevel.spriteList.x)/Math.abs(player.pos.x - curLevel.spriteList.x) *2.5;
		}
		curLevel.update(3);
		player.update(3);
	}
	public function emd(e:MouseEvent):Void {
		if (e.target == createAnObjectSubmit) return;
		if (Std.is(e.target,Sprite)) {
			var s:Sprite = cast(e.target, Sprite);
		//	trace(s.name);
			drag = s;
		}
	}
	public function emm(e:MouseEvent):Void {
		if (drag!=null) {
			drag.x = e.stageX - drag.width / 2 - curLevel.spriteList.x;
			drag.y = e.stageY - drag.height / 2-curLevel.spriteList.y;
		}
	}
	public function emu(e:MouseEvent):Void {
		drag = null;
	}
	public function createAnObjectClick(e:MouseEvent):Void {
		curLevel.addEntity(createAnObject.text,-curLevel.spriteList.x);
	}
}
