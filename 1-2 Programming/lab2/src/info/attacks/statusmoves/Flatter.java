package info.attacks.statusmoves;
import ru.ifmo.se.pokemon.*;
public class Flatter extends StatusMove {
    public Flatter() {
        super(Type.DARK, 0, 100);
    }
    //Повышает спец. атаку цели на одну ступень и сбивает её с толку
    @Override
    protected void applyOppEffects(Pokemon pok) {
        pok.setMod(Stat.SPECIAL_ATTACK, 1);
        Effect.confuse(pok);
    }
    @Override
    protected String describe() {
        return "использует атаку Flatter";
    }
}
