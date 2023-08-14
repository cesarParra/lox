public class RuntimeError extends RuntimeException {
    final Token token;
    final String message;

    RuntimeError(Token token, String message) {
        this.token = token;
        this.message = message;
    }
}
