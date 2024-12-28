package info.pokemons;
import info.attacks.specialmoves.FocusBlast;
import info.attacks.statusmoves.CalmMind;
import info.attacks.statusmoves.Flatter;
import info.attacks.statusmoves.Withdraw;
import ru.ifmo.se.pokemon.*;
public class TapuBulu extends Pokemon {
    public TapuBulu(String name, int level) {
        super(name, level);
        setStats(70, 130, 115, 85, 95, 75);
        setType(Type.GRASS, Type.FAIRY);
        setMove(new Flatter(), new FocusBlast(), new Withdraw(), new CalmMind());
    }
}
