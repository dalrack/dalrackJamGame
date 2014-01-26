package ;
import flash.display.Bitmap;
import flash.display.Sprite;
import openfl.Assets;
import haxe.Json;
#if windows
import sys.FileSystem;
import sys.io.File;
#end
/**
 * ...
 * @author jesus
 */
class Level
{
	public var spriteList:Sprite;
	public var currLevelMap:Bitmap;
	
	public var animatable:Array<Player>;
	
	public function new(number:Int) 
	{
		
		spriteList = new Sprite();
		var bmp:Bitmap = new Bitmap(Assets.getBitmapData("img/levelback"+number+".png"));
		spriteList.addChild(currLevelMap = bmp);
		animatable = new Array<Player>();
		var saved:String = Assets.getText("levels/level" + number + ".js");
		var t:Dynamic = Json.parse(saved);
		try {
			var i:Int=0;
			while (true) {
				var pp:Player;
				if (t[i] == null) break;
				animatable.push(pp=new Player());
				pp.loadFromJson(t[i++]);
				spriteList.addChild(pp.display);
			}
		}catch(e:String){}
	}
	public function update(tpu:Int):Void {
		for (i in animatable) {
			i.update(tpu);
		}
	}
	public function addEntity(name:String, x:Float):Void {
		animatable.push(new Player(name));
		spriteList.addChild(animatable[animatable.length - 1].display);
		animatable[animatable.length - 1].display.x = x;
	}
	public function findEntity(s:Sprite):Player {
		for (i in animatable) {
			if (s == i.display) {
				return i;
			}
		}
		return null;
	}
	public function removeEntity(s:Sprite):Void {
		var p:Player = findEntity(s);
		animatable.remove(p);
		spriteList.removeChild(s);
	}
	/*
	public function save():String {
		var json:String = "";
		for (i in animatable) {
			var pj:PlayerJson = new PlayerJson(i);
			json += Json.stringify(pj);
		}
		trace(json);
		return json;
	}
	*/
	#if windows
	public function save(overwrite:Bool=true,levelFile:Int):Void {
		var filename:String = "level";
		var directory:String = "../../../../assets/levels";
		if (!FileSystem.exists(directory)){
			FileSystem.createDirectory(directory);
		}
		var number:Int = levelFile;
		directory += "/";
		if (FileSystem.exists(directory + filename + ".js")){
			while(FileSystem.exists(directory + filename + number +".js"))
				number++;
		}
		if (overwrite)
			number = levelFile;
		filename = filename + number;
		File.write(directory + filename + ".js", false);
		var json:String = "[";
		var apj:Array<PlayerJson> = new Array<PlayerJson>();
		for (i in animatable) {
			var pj:PlayerJson = new PlayerJson(i);
			json += Json.stringify(pj);
			apj.push(pj);
		}
		json += "]";
		json = Json.stringify(apj);
		File.saveContent(directory + filename + ".js", json);
	}
	/*
	public function load():Void {
				var filename:String = "map";
		var directory:String = "../../../../assets/levels";
		if (!FileSystem.exists(directory)){
			FileSystem.createDirectory(directory);
		}
		var number:Int = 1;
		directory += "/";
		if (FileSystem.exists(directory + filename + ".xml")){
			while(FileSystem.exists(directory + filename + number +".xml"))
				number++;
		}
		number = 1;
		filename = filename + number;
	//	File.write(directory + filename + ".xml", false);
	
		var content:String = File.getContent(directory + filename + ".xml");
		var lines:Array<String> = content.split("\n");
		var i:Int = 0;
		for (x in 0...blocks.length) {
			for (y in 0...blocks[x].length) {
				trace(lines[i]);
				blocks[x][y].load(lines[i].split(","));
				i++;
			}
		}
		
	}*/
	#end
}