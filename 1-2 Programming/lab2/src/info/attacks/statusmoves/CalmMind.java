package info.attacks.statusmoves;
import ru.ifmo.se.pokemon.*;
public class CalmMind extends StatusMove {
    public CalmMind(){
        super(Type.PSYCHIC, 0, 0);
    }
    //Повышает свою Спец. Атаку и Спец. Защиту на одну ступень каждую.
    @Override
    protected void applySelfEffects(Pokemon pok) {
        pok.setMod(Stat.SPECIAL_ATTACK, 1);
        pok.setMod(Stat.SPECIAL_DEFENSE, 1);
    }
    @Override
    protected String describe(){
        return "использует атаку Calm Mind";
    }
}
