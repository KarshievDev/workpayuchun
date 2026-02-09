/// A model class used to represent a selectable item.
class MultiSelectItem<T> {
   final T value;
   final String label;
   String? year;
   String? institution;
   bool selected;

  MultiSelectItem({required this.value,required  this.label,this.year,this.institution,this.selected = false});
}
