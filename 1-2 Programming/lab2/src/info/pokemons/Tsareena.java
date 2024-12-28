package info.pokemons;
import info.attacks.specialmoves.DazzlingGleam;
import info.attacks.statusmoves.PlayNice;
import info.attacks.statusmoves.Rest;
import info.attacks.statusmoves.Swagger;
import ru.ifmo.se.pokemon.*;
public class Tsareena extends Steenee {
    public Tsareena(String name, int level) {
        super(name, level);
        setStats(72, 120, 98, 50, 98, 72);
        setType(Type.GRASS);
        setMove(new Rest(), new Swagger(), new PlayNice(), new DazzlingGleam());
    }
}
