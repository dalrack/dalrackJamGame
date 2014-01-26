package ;
import flash.geom.Point;

/**
 * ...
 * @author jesus
 */
class PlayerJson
{
	var posx:Float;
	var posy:Float;
	var animState:String;
	public function new(player:Player) 
	{
		posx = player.display.x;
		posy=player.display.y;
		animState = player.currAnim;
	}
	
}