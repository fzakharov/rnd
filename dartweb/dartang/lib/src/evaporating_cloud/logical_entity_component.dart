import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

@Component(
  selector: 'logical-entity',
  styleUrls: ['logical_entity_component.css'],
  templateUrl: 'logical_entity_component.html',
  directives: [
    MaterialCheckboxComponent,
    MaterialFabComponent,
    MaterialIconComponent,
    materialInputDirectives,
    NgFor,
    NgIf,
  ],
)
class LogicalEntityComponent implements OnInit {
  LogicalEntityComponent();

  @override
  Future<Null> ngOnInit() async {

  }
}
