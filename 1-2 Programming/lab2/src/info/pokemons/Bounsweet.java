package info.pokemons;
import ru.ifmo.se.pokemon.*;
import info.attacks.statusmoves.Rest;
import info.attacks.statusmoves.Swagger;
public class Bounsweet extends Pokemon {
    public Bounsweet(String name, int level) {
        super(name, level);
        setStats(42, 30, 38, 30, 38, 32);
        setType(Type.GRASS);
        setMove(new Rest(), new Swagger());
    }
}
