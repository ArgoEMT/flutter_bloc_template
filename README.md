# Template Flutter BLoC
Ce projet est un template permettant le lancement rapide d'une application Flutter utilisant BLoC.

## Prérequis 
### Environnement
- [FVM (Flutter Version Management)](https://fvm.app/): Permet de gérer la version du SDK Flutter via le fichier `fvm_config.json`.

### Extensions VSCode
- [Flutter](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter): Extension officielle gérée par l'équipe Flutter.
- [bloc](https://marketplace.visualstudio.com/items?itemName=FelixAngelov.bloc): Permet la génération des widgets et fichiers BLoC. Développée par le créateur de BLoC.
- [Dart Data Class Generator _(optionnel)_](https://marketplace.visualstudio.com/items?itemName=hzgood.dart-data-class-generator): Facilite la création des modèles de données.
- [dart-import (_optionnel_)](https://marketplace.visualstudio.com/items?itemName=luanpotter.dart-import): Nettoie automatiquement les imports pour les convertir en chemins relatifs.
- [flutter-stylizer (_optionnel_)](https://marketplace.visualstudio.com/items?itemName=gmlewis-vscode.flutter-stylizer): Permet de mettre en forme le code Flutter automatiquement. _Il est possible de [personnaliser](#Flutter-Stylizer) l'ordre des objets dans les options._
- [Json to Dart Model](https://marketplace.visualstudio.com/items?itemName=hirantha.json-to-dart): Génère un modèle de document à partir d'un JSON. Pratique lors de la création des classes de retour API.
- [Pubspec Dependency Search](https://marketplace.visualstudio.com/items?itemName=everettjf.pubspec-dependency-search): Fait le lien entre le `pubspec.yaml` et le site [pub.dev](https://pub.dev).

## Packages utilisés
- `get_it`: Permet l'injection de dépendances sans utiliser le contexte.
- `logger`: Pour une gestion plus simple des logs.
- `hive`: Base locale noSQL, pouvant être remplacée par [isar](https://pub.dev/packages/isar).
- `shared_preferences`: Gestion des shared preferences du téléphone. _Les shared preferences ne remplacent pas une base locale_.
- `path_provider`: Gestion simple des chemins d'accès, notamment sur mobile.
- `flutter_bloc`: Package BLoC adapté à Flutter.
- `okteo_flutter_icons`: Package d'icônes SVG customisées.


## Fonctionnement de BLoC
Le `BLoC` (ou `Cubit`) remplace un viewmodel "classique". Il est responsable de la gestion de la logique de l'écran et de l'exécution des appels à la couche de _data_.
Comme un viewmodel, il peut être défini au moment où il est utilisé, dans la methode `build` d'un _widget_. Mais il peut aussi être défini globalement au moment de l'initialisation de l'app, grâce à un `BlocProvider`:
```dart
// app.dart
...
return MultiBlocProvider(
	providers: BlocSetup.globalBlocs,
	child: MaterialApp(
		...
	),
);
```

Dans cet exemple, nos `BLoC` sont définies dans le fichier `bloc_setup.dart`:
```dart
// bloc_setup.dart
class BlocSetup {
	static List<BlocProvider> globalBlocs = [
		BlocProvider(create: (context) => ConnectivityCubit())
		...
	];
}
```

Une fois définie, le `BLoC` peut se récupérer via le `context`:
```dart
final bloc = context.read<ConnectivityCubit>();
// ou
ConnectivityCubit bloc = context.read();
```

_Il est aussi possible d'utiliser un `BlocProvider` dans un widget pour le transmettre à ses enfants via le `context`. Cependant, je préfère les passer en paramètre, car cela rend le débogage plus facile en cas d'oubli, même si cela complexifie l'écran._

### BLoC
Flutter `BLoC` fonctionne en utilisant un système d'échange d'états (State) et d'événements (Event).

![bloc architecture](readme_img/bloc_architecture_full.webp)

#### BLoC
Le `BLoC` est l'équivalent du viewmodel. Il intercepte les événements (`events`), effectue une logique, et envoie des états (`states`).

#### State
Les états (`states`) sont des objets que le `BLoC` envoie vers l'écran. Ils sont définis dans un fichier et héritent tous d'une classe abstraite.

#### Event
Les événements (`events`), tout comme les états (`states`), sont des objets. Cette fois, ils sont envoyés de l'écran vers le `BLoC`. Lorsque le `BLoC` les intercepte, il effectue une logique définie par le développeur et peut envoyer un état.

### Cubit
Le `Cubit` est une version simplifiée du `BLoC`, qui n'utilise pas les événements pour communiquer, mais directement des méthodes définies dans le ` Cubit`.

![cubit architecture](readme_img/Cubit_architecture_full.webp)

### Lien avec l'écran
Pour faire le lien avec l'écran, on utilise un `BlocBuilder`:
```dart
...
Widget build(BuildContext context) {
	final Cubit = HomeCubit()..init();
	  
	return AppBody(
		title: 'Home',
		body: Padding(
			padding: const EdgeInsets.all(24.0),
			child: BlocBuilder(
				bloc: Cubit,
				builder: (BuildContext context, HomeState state) {
					...
				},
			),
		),
	);
}
```

Dans le `builder` du `BlocBuilder`, on a accès au `state` renvoyé par le `BLoC`. À chaque fois qu'un nouveau `state` est émis, le contenu du `builder` est rafraîchi, il est donc possible de changer l'affichage en fonction du `state`.
```dart
...
builder: (BuildContext context, HomeState state) {
	if (state is HomeLoadingState || state is HomeInitialState) {
		return const Center(child: CircularProgressIndicator());
	}
	if (state is HomeLoadedState) {
		return Column(
			mainAxisSize: MainAxisSize.min,
			children: [
				Row(
					mainAxisAlignment: MainAxisAlignment.center,
					children: state.data.map((e) => Text(e)).toList(),
				),
				const SizedBox(height: 24.0),
				OutlinedButton(
					onPressed: Cubit.loadMore,
					child: const Text('Load More'),
				),
			],
		);
	}
	return const Center(child: Text('Error'));
},
...
```

### Cubit ou BLoC ?
Le BLoC est plus recommandé lorsque des tests automatiques sont mis en place, car l'architecture `State`/`Event` simplifierait l'écriture des tests.
Cependant, les Cubits sont [plus simples](#Annexes) à gérer, écrire et comprendre. Je recommande leur utilisation lorsque c'est possible.


## Structure du template

```
├── config/
	└── theme/
├──core/
    ├── constants/
    ├── global_blocs/
    ├── models/
    └── services/
├── helpers/
└── ui/
	├── components/
	├── screens/
		└── example_screen/
			├── components/
			├── example_bloc/
			└── example_screen.dart
	└── ui_helpers/
```

- `config`: Contient la configuration de l'application, telle que le routeur et la définition des variantes (flavors)...
- `core`: Comprend la logique de base de l'application, avec les modèles, les services, etc...
- `helpers`: Contient les fonctions et extensions globales de l'application qui n'interagissent pas avec l'interface utilisateur.
- `ui`: Contient la couche visible de l'application, où l'on trouve les composants partagés, les écrans et les utilitaires qui sont liés à l'interface utilisateur.

_On note que le dossier d'un écran comprend son `BLoC`._


## Annexes

### BLoC vs Cubit
Différence entre `BLoC` et `Cubit` pour l'écran `HomeScreen`.

#### BLoC
```dart
// home_state.dart
part of 'home_Cubit.dart'; 

sealed class HomeState {}
  
final class HomeInitialState extends HomeState {}
  
final class HomeLoadingState extends HomeState {}
  
final class HomeLoadedState extends HomeState {
	HomeLoadedState(this.data);
	final List<String> data;
}
```

```dart
// home_event.dart
part of 'home_bloc.dart';


sealed class HomeEvent {}

final class HomeInitEvent extends HomeEvent {}

final class HomeLoadMoreEvent extends HomeEvent {}
```

```dart
// home_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';
  
class HomeBloc extends Bloc<HomeEvent, HomeState> {
	HomeBloc() : super(HomeInitial()) {
		on<HomeInitEvent>((event, emit) async {
			emit(HomeLoadingState());
			await _homeService.getHomeData().then(
				(data) => emit(HomeLoadedState(data)),
			);
		});
		on<HomeLoadMoreEvent>((event, emit) async {
			if (state is! HomeLoadedState) return;
			final currentData = [...((state as HomeLoadedState).data)];
			emit(HomeLoadingState());
			await _homeService.getMoreData().then((data) => emit(
				HomeLoadedState([...currentData, ' ', ...data]),
			));
		});
	}
}
```

```dart
// home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
  
import '../../components/app_body.dart';
import 'home_Cubit/home_Cubit.dart';
  
class HomeScreen extends StatelessWidget {
	const HomeScreen({super.key});
	  
	@override
	Widget build(BuildContext context) {
		final bloc = HomeBloc()..add(HomeInitEvent());
		  
		return AppBody(
			title: 'Home',
			body: Padding(
				padding: const EdgeInsets.all(24.0),
				child: BlocBuilder(
					bloc: bloc,
					builder: (BuildContext context, HomeState state) {
						if (state is HomeLoadingState || state is HomeInitialState) {
							return const Center(child: CircularProgressIndicator());
						}
						if (state is HomeLoadedState) {
							return Column(
								mainAxisSize: MainAxisSize.min,
								children: [
									Row(
										mainAxisAlignment: MainAxisAlignment.center,
										children: state.data.map((e) => Text(e)).toList(),
									),
									const SizedBox(height: 24.0),
									OutlinedButton(
										onPressed: () {
											bloc.add(HomeLoadMoreEvent)
										},
										child: const Text('Load More'),
									),
								],
							);
						}
						return const Center(child: Text('Error'));
					}
				),
			),
		);
	}
}
```

#### Cubit

```dart
// home_state.dart
part of 'home_Cubit.dart'; 

sealed class HomeState {}
  
final class HomeInitialState extends HomeState {}
  
final class HomeLoadingState extends HomeState {}
  
final class HomeLoadedState extends HomeState {
	HomeLoadedState(this.data);
	final List<String> data;
}
```

```dart
// home_Cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
  
import '../../../../core/services/home_service.dart';
  
part 'home_state.dart';
  
class HomeCubit extends Cubit<HomeState> {
	HomeCubit() : super(HomeInitialState());
	final _homeService = HomeService();
	  
	Future init() async {
		emit(HomeLoadingState());
		await _homeService.getHomeData().then(
			(data) => emit(HomeLoadedState(data)),
		);
	}
	  
	Future loadMore() async {
		if (state is! HomeLoadedState) return;
		final currentData = [...((state as HomeLoadedState).data)];
		emit(HomeLoadingState());
		await _homeService.getMoreData().then((data) => emit(
			HomeLoadedState([...currentData, ' ', ...data]),
		));
	}
}
```

```dart
// home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
  
import '../../components/app_body.dart';
import 'home_Cubit/home_Cubit.dart';
  
class HomeScreen extends StatelessWidget {
	const HomeScreen({super.key});
	  
	@override
	Widget build(BuildContext context) {
		final Cubit = HomeCubit()..init();
		  
		return AppBody(
			title: 'Home',
			body: Padding(
				padding: const EdgeInsets.all(24.0),
				child: BlocBuilder(
					bloc: Cubit,
					builder: (BuildContext context, HomeState state) {
						if (state is HomeLoadingState || state is HomeInitialState) {
							return const Center(child: CircularProgressIndicator());
						}
						if (state is HomeLoadedState) {
							return Column(
								mainAxisSize: MainAxisSize.min,
								children: [
									Row(
										mainAxisAlignment: MainAxisAlignment.center,
										children: state.data.map((e) => Text(e)).toList(),
									),
									const SizedBox(height: 24.0),
									OutlinedButton(
										onPressed: Cubit.loadMore,
										child: const Text('Load More'),
									),
								],
							);
						}
						return const Center(child: Text('Error'));
					}
				),
			),
		);
	}
}
```

### Flutter-Stylizer
```json
"flutterStylizer": {
	"memberOrdering": [
		"public-constructor",
		"named-constructors",
		"private-static-variables",
		"public-static-variables",
		"private-instance-variables",
		"public-instance-variables",
		"public-override-variables",
		"public-override-methods",
		"private-other-methods",
		"public-other-methods",
		"build-method"
	],
	"groupAndSortGetterMethods": true,
	"groupAndSortVariableTypes": true,
	"sortOtherMethods": true,
	"processEnumsLikeClasses": false,
	"sortClassesWithinFile": false
}
```
