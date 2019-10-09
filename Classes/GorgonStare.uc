class GorgonStare expands SpecialEvent;

var Actor      HitActor;
var Barrel     Statue;
var PlayerPawn P;
var Vector     X, Y, Z, HitLocation, HitNormal, EndTrace, StartTrace;

function Tick(float Delta) {
	foreach AllActors(Class'PlayerPawn', P) {
		if (
			!P.PlayerReplicationInfo.bIsSpectator &&
			P.Region.Zone.Tag == 'GorgonZone'     &&
			P.Health > 0
		) {
			CheckGorgonStare(P);
		}
	}
}

function CheckGorgonStare(PlayerPawn P) {
	GetAxes(P.ViewRotation, X, Y, Z);

	StartTrace = P.Location + P.EyeHeight * vect(0, 0, 1);
	EndTrace   = StartTrace + X * 10000;
	HitActor   = Trace(HitLocation, HitNormal, EndTrace, StartTrace, true);

	if (Pawn(HitActor) != none && Pawn(HitActor).IsA('GorgonPawn')) {
		self.Trigger(P, P);
	}
}

state() PetrifyInstigator {
	function Trigger(actor Other, pawn P) {
		Statue      = Spawn(class'PlayerStatue',,, P.Location, Rotator(X));
		Statue.Mesh = P.Mesh;
		Statue.SetCollisionSize(P.CollisionRadius, P.CollisionHeight);

		Level.Game.SpecialDamageString = DamageString;
		P.Died(P, DamageType, P.Location);
	}
}

DefaultProperties {
	DamageString="%k was petrified!"
	DamageType=SpecialDamage
	InitialState=PetrifyInstigator
}