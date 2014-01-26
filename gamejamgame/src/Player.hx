package ;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Transform;
import openfl.Assets;

/**
 * ...
 * @author jesus
 */
class Player
{
	public var pos:Point;
	public var movespeed:Float = 4;
	public var display:Sprite;
	public var displayBitmap:Bitmap;
	public var anims:Array<Array<BitmapData>>;
	
	public var animGroup:String;
	private var animLength:Int;
	public var animStrings:Array<String>;
	public var currAnim:String;
	public var currFrame:Int;
	
	public var facing:Bool = false;
	
	private static var animSpeed:Int = 30;
	private var animTTU:Int = 0;
	
	public var screenOff:Point;
	public function new(animGroup:String=null) 
	{
		this.animGroup = animGroup;
		screenOff = new Point();
		animStrings = new Array<String>();
		animStrings.push("walk");
		animStrings.push("stand");
		currAnim = "stand";
		
		pos = new Point();
		
		display = new Sprite();
		if (animGroup != null) {
			setAnimGroup(animGroup);
		}
		
		
	}
	public function setAnimGroup(group:String):Void {
		anims = new Array<Array<BitmapData>>();
		
		for (i in 0...animStrings.length) {
			anims.push(new Array<BitmapData>());
			var j:Int = 0;
			var bmpdata:BitmapData=null ;
			if (Assets.exists("img/"+animGroup+"/"+animStrings[i]+"_"+0+".png",AssetType.IMAGE))
				bmpdata = Assets.getBitmapData("img/"+animGroup+"/"+animStrings[i]+"_"+0+".png");
			while (bmpdata!=null) {
				anims[i].push(bmpdata);
				j++;
				if (Assets.exists("img/" + animGroup + "/" + animStrings[i] + "_" + j + ".png",AssetType.IMAGE)) {
					bmpdata = Assets.getBitmapData("img/"+animGroup+"/" + animStrings[i] + "_" + j + ".png");
				}
				else bmpdata = null;
			}
		}
		
		
		displayBitmap = new Bitmap(anims[0][0]);
		setDirection(false);
		display.addChild(displayBitmap);
	}
	public function loadFromJson(pj:Dynamic):Void {
		pos.x = pj.posx;
		pos.y = pj.posy;
	//	trace(pos.x);
		animGroup = pj.animGroup;
		if (animGroup != null) {
			setAnimGroup(animGroup);
		}
		currAnim = pj.animState;
		display.x = pos.x;
		display.y = pos.y;
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
			displayBitmap.bitmapData = anims[aIndex][currFrame];
		}
	}
	public function setDirection(left:Bool):Void {
		var t:Transform = display.transform;	
		if (left) {
			t.matrix = new Matrix( -1, 0, 0, 1,  screenOff.x + displayBitmap.width / 2, t.matrix.ty);
			facing = true;
		}
		else {
			t.matrix = new Matrix( 1, 0, 0, 1, screenOff.x - displayBitmap.width / 2 , t.matrix.ty);
			facing = false;
		}
		
	}
	
}