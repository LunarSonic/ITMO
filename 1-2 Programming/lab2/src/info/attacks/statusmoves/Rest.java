package info.attacks.statusmoves;
import ru.ifmo.se.pokemon.*;
public class Rest extends StatusMove {
    public Rest() {
        super(Type.PSYCHIC, 0, 0);
    }
    //Всегда накладывает эффект, не наносит урона
    @Override
    protected boolean checkAccuracy(Pokemon att, Pokemon def) {
        return true;
    }
    //Покемон полностью вылечивает себя и засыпает на два хода
    @Override
    protected void applySelfEffects(Pokemon pok) {
        Effect eff = new Effect().condition(Status.SLEEP).turns(2);
        pok.restore();
        pok.addEffect(eff);
    }
    @Override
    protected String describe() {
        return "использует атаку Rest";
    }
}
