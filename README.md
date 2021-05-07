# flutter_form_validator

A new Flutter package.

## Getting Started

This project is a starting point for a Dart
## This package contains code for flutter form validation widgets.
[package](https://github.com/raamsubramani95/flutter_form_validator),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.


# form_field_validator  
  
A straightforward flutter form field validator that provides common validation options.  
  
 ## How to use
 
```dart  
   
TextFormField(
                validator: ValidationBuilder().email().required().maxLength(50).build(),
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 30),
              TextFormField(
                validator:
                    ValidationBuilder().minLength(5).maxLength(50).build(),
                decoration: InputDecoration(
                  labelText: 'Name',
                  helperText: 'Min length: 5, max length: 50',
                ),
              ),
           ],
          ),
        ),
      ), 
  
 ```
     

```dart  
   
 class HomePage extends StatefulWidget {
   @override
   _HomePageState createState() => _HomePageState();
 }
 
 class _HomePageState extends State<HomePage> {
   GlobalKey<FormState> _form = GlobalKey<FormState>();
 
   void _validate() {
     _form.currentState.validate();
   }
 
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('Example'),
       ),
       body: Form(
         key: _form,
         child: SingleChildScrollView(
           padding: const EdgeInsets.all(15),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               TextFormField(
                 validator: ValidationBuilder().email().required().maxLength(50).build(),
                 decoration: InputDecoration(labelText: 'Email'),
               ),
               SizedBox(height: 30),
               TextFormField(
                 validator:
                     ValidationBuilder().minLength(5).maxLength(50).build(),
                 decoration: InputDecoration(
                   labelText: 'Name',
                   helperText: 'Min length: 5, max length: 50',
                 ),
               ),
             ],
           ),
         ),
       ),
       floatingActionButton: FloatingActionButton(
         onPressed: _validate,
         tooltip: 'okay',
         child: Icon(Icons.done),
       ),
     );
   }
 }

    
 ```



              
     
