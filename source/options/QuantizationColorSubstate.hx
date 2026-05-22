package options;

import flixel.util.FlxSpriteUtil;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;

import objects.Note;

class QuantizationColorSubstate extends MusicBeatSubstate
{
	public var notesGroup:FlxTypedGroup<Note>;
	public var btnGroup:FlxTypedGroup<Alphabet>;

	var currentTab:QuantTab;

	override function create() {
		var grid:FlxBackdrop = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0x33FFFFFF, 0x0));
		grid.velocity.set(40, 40);
		grid.alpha = 0;
		add(grid);

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		add(bg);

		var box = new FlxSprite().makeGraphic(850, 500, 0xC9000000);
		box.screenCenter();
		FlxSpriteUtil.drawRect(box, 0, 0, box.width, box.height, 0, {thickness: 10, color: 0xFFFFFFFF});
		add(box);

		notesGroup = new FlxTypedGroup<Note>();
		add(notesGroup);

		btnGroup = new FlxTypedGroup<Alphabet>();
		add(btnGroup);

		FlxTween.tween(grid, { alpha: 1 }, 0.5, { ease: FlxEase.quadOut });
		FlxTween.tween(bg, { alpha: 0.4 }, 0.5, { ease: FlxEase.quadOut });

		reloadTab();

		addTouchPad('NONE', 'B');
		super.create();
	}

	override function update(elapsed:Float) {
		if (controls.BACK) {
			close();
			FlxG.sound.play(Paths.sound('cancelMenu'));
		}

		switch(currentTab) {
			case NOTE_SELECTION:
				
			case NOTE_EDITING:
		}
		super.update(elapsed);
	}

	public function reloadTab(tab:QuantTab = NOTE_SELECTION) {
		switch(tab) {
			case NOTE_SELECTION:
				for (i in 0...8) {
					var note = new Note(0, 0);
					note.scale.x *= 0.95;
					note.scale.y *= 0.95;
					note.x = i > 3 ? 640 : 240;
					note.y = 128 + (120 * (i > 3 ? i-4 : i));
					note.rgbShader.r = Note.quantizations[i][1][0];
					note.rgbShader.g = Note.quantizations[i][1][1];
					note.rgbShader.b = Note.quantizations[i][1][2];
					add(note);

					var alph = new Alphabet(note.x + 160, note.y - 15, Note.quantizations[i][0] + 'th Note', false);
					alph.setScale(0.5, 0.5);
					for (letter in alph.letters) letter.setColorTransform(1, 1, 1, 1, 255, 255, 255, 0);
					add(alph);

					var alph = new Alphabet(note.x + 140, note.y + 60, 'EDIT');
					alph.setScale(0.4, 0.4);
					alph.ID = i;
					btnGroup.add(alph);

					var bg = new FlxSprite(alph.x - 20, alph.y - 5).makeGraphic(Math.round(alph.width * 1.5), Math.round(alph.height * 1.5), 0xFF1A1A1A);
					FlxSpriteUtil.drawRect(bg, 0, 0, bg.width, bg.height, 0, {thickness: 5, color: 0xFFFFFFFF});
					insert(members.indexOf(alph), bg);

					var alph = new Alphabet(alph.x + 120, alph.y, 'RESET');
					alph.setScale(0.4, 0.4);
					alph.ID = i;
					btnGroup.add(alph);

					var bg = new FlxSprite(alph.x - 20, alph.y - 5).makeGraphic(Math.round(alph.width * 1.5), Math.round(alph.height * 1.5), 0xFF1A1A1A);
					FlxSpriteUtil.drawRect(bg, 0, 0, bg.width, bg.height, 0, {thickness: 5, color: 0xFFFFFFFF});
					insert(members.indexOf(alph), bg);
				}
			case NOTE_EDITING:
		}
		currentTab = tab;
	}
}

enum QuantTab
{
	NOTE_SELECTION;
	NOTE_EDITING;
}