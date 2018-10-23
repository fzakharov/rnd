import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

@Component(
  selector: 'evaporating-cloud',
  styleUrls: ['evaporating_cloud_component.css'],
  templateUrl: 'evaporating_cloud_component.html',
  directives: [
    materialInputDirectives,
    NgFor,
    NgIf,
  ],
)
class EvaporatingCloudComponent implements OnInit {
    EvaporatingCloudComponent();

    String Objective;

    String Title = 'no';

  @override
  Future<Null> ngOnInit() async {
    Objective = "Цель ...";
  }

  update() async {
    Title = 'Для того чтобы ' + Objective + ' мы должны...';
  }
}
