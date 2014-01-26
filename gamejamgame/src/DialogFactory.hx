package ;

import openfl.Assets;
import haxe.Json;
/**
 * ...
 * @author jesus
 */
class DialogFactory
{
	public var dialogCollection:Array<Dynamic>;
	public var prevDialogs:Array<String>;
	public var collectedItems:Array<String>;
	public static var totalProgress:Int = 3;
	public function new() 
	{
		prevDialogs = new Array<String>();
		collectedItems = new Array<String>();
		
		var dialogs:String = Assets.getText("base/Dialog.js");
		dialogCollection = new Array<Dynamic>();
		var t:Dynamic = Json.parse(dialogs);
		try {
			var i:Int=0;
			while (true) {
				if (t[i] == null) break;
				dialogCollection.push(t[i]);
				i++;
			}
		}catch(e:String){}
	}
	public function dialogsBeenSaid(s:String):Bool {
		if (s =="none") return true;
		for (i in prevDialogs) {
			if (s == i) return true;
		}
		return false;
	}
	public function getdialog(npc:String):String {
		var dgs:Array<Dynamic> = new Array<Dynamic>();
		for (i in 0...dialogCollection.length) {
			if (dialogCollection[i].srcPlayer == npc) {
				dgs.push(dialogCollection[i]);
				
			}
		}
		var dgs2:Array<Dynamic> = new Array<Dynamic>();
		for (i in 0...dgs.length) {
			if (dialogCollection[i].repeatable=="no" && dialogsBeenSaid(dialogCollection[i].ID)) {
				continue;
			}
			else if (!dialogsBeenSaid(dialogCollection[i].dialogdependancy)) {//the dependancy hasn't been said yet
				continue;
			}
			else
				dgs2.push(dgs[i]);
		}
		var selected:Int = Std.random(dgs2.length);
		var ret:String = "";
		if (dgs2.length>0){
			prevDialogs.push(dgs2[selected].ID);
			ret = dgs2[selected].dialog;
		}
		return ret;
	}
	
}