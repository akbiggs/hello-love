Talker = {
	shouldTalkOnApproach = false,
	defaultDialogueSpeed = 5,
	curDialogue = nil,

	say = function(self, dialogue, time)
		time = time or self.defaultDialogueSpeed
		self.curDialogue = Dialogue:new(self.world, self, dialogue, time)
		self.world:add(self.curDialogue)
	end;
}