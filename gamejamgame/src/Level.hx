package ;
import flash.display.Bitmap;
import flash.display.Sprite;
import openfl.Assets;
/**
 * ...
 * @author jesus
 */
class Level
{
	public var spriteList:Sprite;
	public var currLevelMap:Bitmap;
	
	public var animatable:Array<Player>;
	public function new() 
	{
		animatable = new Array<Player>();
		animatable.push(new Player());
		spriteList = new Sprite();
		var bmp:Bitmap = new Bitmap(Assets.getBitmapData("img/levelback.png"));
		spriteList.addChild(currLevelMap=bmp);
		spriteList.addChild(animatable[0].display);
	}
	
}