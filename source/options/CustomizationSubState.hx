package options;

class CustomizationSubState extends MusicBeatSubstate
{
	override function create() {
		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.6;
		add(bg);

		addTouchPad('NONE', 'B');
		super.create();,
	}

	override function update(elapsed:Float) {
		if (controls.BACK) {
			close();
			FlxG.sound.play(Paths.sound('cancelMenu'));
		}
		super.update(elapsed);
	}
}