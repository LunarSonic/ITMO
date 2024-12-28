package info.pokemons;
import ru.ifmo.se.pokemon.*;
import info.attacks.statusmoves.Charm;
import info.attacks.statusmoves.DoubleTeam;
import info.attacks.statusmoves.Swagger;
public class Glameow extends Pokemon {
    public Glameow(String name, int level) {
        super(name, level);
        setStats(49, 55, 42, 42, 37, 85);
        setType(Type.NORMAL);
        setMove(new Swagger(), new DoubleTeam(), new Charm());
    }
}
