package info.pokemons;
import info.attacks.statusmoves.PlayNice;
import info.attacks.statusmoves.Rest;
import info.attacks.statusmoves.Swagger;
import ru.ifmo.se.pokemon.*;
public class Steenee extends Bounsweet {
    public Steenee(String name, int level) {
        super(name, level);
        setStats(52, 40, 48, 40, 48, 62);
        setType(Type.GRASS);
        setMove(new Rest(), new Swagger(), new PlayNice());
    }
}
