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
	
	private static var animSpeed:Int = 30;
	private var animTTU:Int = animSpeed;
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
	public function update(tpu:Int):Void {
		animTTU -= tpu;
		if (animTTU <= 0) {
			animStrings.
			animTTU = animSpeed;
			var lastFrame:Int=anims[
			display.bitmapData=anims[][
		}
	}
	
}