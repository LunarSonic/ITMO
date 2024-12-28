package info.attacks.statusmoves;
import ru.ifmo.se.pokemon.*;
public class PlayNice extends StatusMove{
    public PlayNice() {
        super(Type.NORMAL, 0, 0);
    }
    //Понижает атаку цели на одну ступень
    @Override
    protected void applyOppEffects(Pokemon pok) {
        Effect eff = new Effect();
        eff.stat(Stat.ATTACK, -1);
        pok.addEffect(eff);
    }
    @Override
    protected String describe() {
        return "использует атаку Play Nice";
    }
}
