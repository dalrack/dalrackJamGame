package ;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import openfl.Assets;

/**
 * ...
 * @author jesus
 */
class Player
{
	public var pos:Point;
	public var movespeed:Float = 4;
	public var display:Bitmap;
	public var anims:Array<Array<BitmapData>>;
	
	private var animLength:Int;
	public var animStrings:Array<String>;
	public var currAnim:String;
	public var currFrame:Int;
	
	private static var animSpeed:Int = 30;
	private var animTTU:Int = 0;
	public function new() 
	{
		animStrings = new Array<String>();
		animStrings.push("walk");
		animStrings.push("stand");
		
		display=new Bitmap(Assets.getBitmapData("img/gradient.png"));
		pos = new Point();
		anims = new Array<Array<BitmapData>>();
		for (i in 0...animStrings.length) {
			anims.push(new Array<BitmapData>());
			var j:Int = 0;
			var bmpdata:BitmapData = Assets.getBitmapData("img/player/"+animStrings[i]+"_"+0+".png");
			while (bmpdata!=null) {
				anims[i].push(bmpdata);
				j++;
				if (Assets.exists("img/player/"+animStrings[i]+"_"+j+".png"))
					bmpdata = Assets.getBitmapData("img/player/" + animStrings[i] + "_" + j + ".png");
				else bmpdata = null;
			}
		}
	}
	
	public function searchArray(a:Array<String>, s:String):Int {
		for (i in 0...a.length) {
			if (a[i] == s) 
				return i;
		}
		return 0;
	}
	
	public function update(tpu:Int):Void {
		animTTU -= tpu;
		if (animTTU <= 0) {
			var aIndex = searchArray(animStrings, currAnim);
			animTTU = animSpeed;
			currFrame++;
			var lastFrame:Int = anims[aIndex].length;
			if (currFrame >= lastFrame) 
				currFrame = 0;
			display.bitmapData = anims[aIndex][currFrame];
		}
	}
	
}