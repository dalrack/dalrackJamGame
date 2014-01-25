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
/**
 * ...
 * @author jesus
 */

class Main extends Sprite 
{
	var inited:Bool;

	var player:Player ;
	var currLevelMap:Bitmap;
	
	var mLeft:Bool=false;
	var mRight:Bool = false;
	
	var texthandler:TextHandler;
	
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
		player = new Player();
		texthandler = new TextHandler();
		// (your code here)
		
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
		
		var bmp:Bitmap = new Bitmap(Assets.getBitmapData("img/levelback.png"));
		addChild(currLevelMap=bmp);
		
		addChild(player.display);
		player.display.x = stage.stageWidth / 2 + player.display.width / 2;
		player.display.y = stage.stageHeight - player.display.height-20;
		player.screenOff.x = player.display.x;
		player.screenOff.y = player.display.y;
		
		
		addEventListener(Event.ENTER_FRAME, update);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		
	}

	/* SETUP */

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
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
		
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
			
		}
		else if (e.keyCode == 65) {//a
			mLeft = false;
			player.pos.x = currLevelMap.x;
			player.currAnim="stand";
		}
		else if (e.keyCode == 83) {//s
			
		}
		else if (e.keyCode == 68) {//d
			mRight = false;
			player.pos.x = currLevelMap.x;	
			player.currAnim="stand";
		}
	}
	
	public function update(e:Event):Void {
		if (mLeft) {
			if (player.pos.x<=0)
				player.pos.x += player.movespeed;
				
			player.setDirection(true);
		}
		if (mRight) {
			
			if (player.pos.x>=-currLevelMap.width+stage.stageWidth+10)
				player.pos.x -= player.movespeed;
			player.setDirection(false);
		}
		if (mLeft || mRight) player.currAnim = "walk";
		if (Math.abs(currLevelMap.x-player.pos.x)>.1){
			currLevelMap.x += (player.pos.x - currLevelMap.x)/Math.abs(player.pos.x - currLevelMap.x) *2.5;
		}
		
		player.update(3);
	}
}
