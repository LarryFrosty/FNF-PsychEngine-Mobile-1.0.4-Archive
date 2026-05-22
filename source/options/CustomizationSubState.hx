package options;

class CustomizationSubState extends MusicBeatSubstate
{
	override function create() {
		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		add(bg);

		FlxTween.tween(bg, { alpha: 0.6 }, 0.5);

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