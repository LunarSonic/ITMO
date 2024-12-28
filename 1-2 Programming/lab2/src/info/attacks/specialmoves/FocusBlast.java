package info.attacks.specialmoves;
import ru.ifmo.se.pokemon.*;
public class FocusBlast extends SpecialMove {
    public FocusBlast() {
        super(Type.FIGHTING, 120, 70);
    }
    //Имеет 10% вероятность понизить Спец. Защиту цели на одну ступень
    @Override
    protected void applyOppEffects(Pokemon pok) {
        if(Math.random() <= 0.1) {
            Effect eff = new Effect();
            eff.stat(Stat.SPECIAL_DEFENSE, -1);
            pok.addEffect(eff);
        }
    }
    @Override
    protected String describe() {
        return "использует атаку Focus Blast";
    }
}
