package exceptions;
public class InvalidCharacterSpeedException extends Exception {
    public InvalidCharacterSpeedException(String message) {
        super(message);
    }
    @Override
    public String getMessage() {
        return "Такая скорость не может быть у персонажа" + super.getMessage();
    }
}
