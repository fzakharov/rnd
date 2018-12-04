import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'src/evaporating_cloud/evaporating_cloud_component.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  providers: const [materialProviders],
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: [EvaporatingCloudComponent],
)
class AppComponent {

}
