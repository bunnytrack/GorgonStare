class GorgonPawn expands Pawn;

function TakeDamage(int Damage, Pawn Instigator, Vector HitLocation, Vector Momentum, name DamageType) {}

DefaultProperties {
	bEdShouldSnap=True
	CollisionHeight=96
	CollisionRadius=96
	Style=STY_Translucent
}