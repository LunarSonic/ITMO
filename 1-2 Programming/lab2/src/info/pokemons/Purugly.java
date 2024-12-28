package info.pokemons;
import info.attacks.physicalmoves.BodySlam;
import info.attacks.statusmoves.Charm;
import info.attacks.statusmoves.DoubleTeam;
import info.attacks.statusmoves.Swagger;
import ru.ifmo.se.pokemon.*;
public class Purugly extends Glameow {
    public Purugly(String name, int level) {
        super(name, level);
        setStats(71, 82, 64, 64, 59, 112);
        setType(Type.NORMAL);
        setMove(new Swagger(), new DoubleTeam(), new Charm(), new BodySlam());
    }
}