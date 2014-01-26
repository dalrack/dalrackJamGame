package ;
import flash.geom.Point;

/**
 * ...
 * @author jesus
 */
class PlayerJson
{
	public var posx:Float;
	public var posy:Float;
	public var animState:String;
	public var animGroup:String;
	//see level:new and duplicate modifications and player.loadJson
	//this was a pretty big mistake to use this because I can't find a clean way to deserialize.
	public function new(player:Player=null) 
	{
		if (player!=null){
			posx = player.display.x;
			posy=player.display.y;
			animState = player.currAnim;
			animGroup = player.animGroup;
		}
	}
	
}