class PlayerStatue expands Barrel;

#exec AUDIO   IMPORT FILE=Sounds\StoneCrumble1.wav
#exec TEXTURE IMPORT FILE=Textures\GorgonStone.pcx

function PostBeginPlay() {
	SetTimer(3, false);
}

function Timer() {
	Shatter();
}

function Shatter() {
	skinnedFrag(class'StatueFragments', Texture'GorgonStone', vect(4096, -3072, -1024), 1, 10);
	PlaySound(Sound'StoneCrumble1', SLOT_None, 5,, 512, 0.75);
}

auto state Animate {
	function TakeDamage(int NDamage, Pawn Instigator, Vector Hitlocation, Vector Momentum, name damageType) {
		bBobbing = false;

		if (Health < 0) {
			return;
		}

		if (Instigator != none) {
			MakeNoise(1);
		}

		Health -= NDamage;

		if (Health < 0) {
			Shatter();
		} else {
			SetPhysics(PHYS_Falling);
			bBounce    = True;
			Momentum.Z = 1000;
			Velocity   = Momentum * 0.01;
		}
	}

	Begin:
}

DefaultProperties {
	MultiSkins(0)=Texture'GorgonStone'
	MultiSkins(1)=Texture'GorgonStone'
	MultiSkins(2)=Texture'GorgonStone'
	MultiSkins(3)=Texture'GorgonStone'
	Physics=PHYS_Falling
}