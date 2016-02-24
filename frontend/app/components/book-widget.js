import Ember from 'ember';

export default Ember.Component.extend({
  actions: {
    addBook(title) {
      this.get('books').pushObject({ title: title });
    }
  }
});
