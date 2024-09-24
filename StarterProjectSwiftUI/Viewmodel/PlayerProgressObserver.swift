




import SMP
import Combine
public class MediaSelectorAuthenticationProvider: NSObject, BBCMediaSelectorAuthenticationProvider {
  var jwtToken: String
  init(jwtToken: String) {
    self.jwtToken = jwtToken
  }
  public func provideAuthentication(_ onSuccess: @escaping (BBCMediaSelectorAuthentication) -> Void, failure
      onFailure: @escaping (Error) -> Void) {
      onSuccess(BBCMediaSelectorJWTAuthentication(token: jwtToken))
  }
}
