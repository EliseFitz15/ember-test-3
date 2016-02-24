import Ember from 'ember';

export default Ember.Component.extend({
  actions: {
    submit() {
      const title = this.get('title');
      this.get('onAdd')(title);
      this.set('title', "");
      this.$('input').focus();
    }
  }
});
