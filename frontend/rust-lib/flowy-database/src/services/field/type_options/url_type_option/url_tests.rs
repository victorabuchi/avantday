#[cfg(test)]
mod tests {
  use crate::entities::FieldType;
  use crate::services::cell::CellDataChangeset;

  use crate::services::field::FieldBuilder;
  use crate::services::field::URLTypeOptionPB;
  use database_model::FieldRevision;

  /// The expected_str will equal to the input string, but the expected_url will be empty if there's no
  /// http url in the input string.
  #[test]
  fn url_type_option_does_not_contain_url_test() {
    let type_option = URLTypeOptionPB::default();
    let field_type = FieldType::URL;
    let field_rev = FieldBuilder::from_field_type(&field_type).build();
    assert_url(&type_option, "123", "123", "", &field_rev);
    assert_url(&type_option, "", "", "", &field_rev);
  }

  /// The expected_str will equal to the input string, but the expected_url will not be empty
  /// if there's a http url in the input string.
  #[test]
  fn url_type_option_contains_url_test() {
    let type_option = URLTypeOptionPB::default();
    let field_type = FieldType::URL;
    let field_rev = FieldBuilder::from_field_type(&field_type).build();
    assert_url(
      &type_option,
      "Avantday website - https://www.avantday.io",
      "Avantday website - https://www.avantday.io",
      "https://www.avantday.io/",
      &field_rev,
    );

    assert_url(
      &type_option,
      "Avantday website avantday.io",
      "Avantday website avantday.io",
      "https://avantday.io",
      &field_rev,
    );
  }

  /// if there's a http url and some words following it in the input string.
  #[test]
  fn url_type_option_contains_url_with_string_after_test() {
    let type_option = URLTypeOptionPB::default();
    let field_type = FieldType::URL;
    let field_rev = FieldBuilder::from_field_type(&field_type).build();
    assert_url(
      &type_option,
      "Avantday website - https://www.avantday.io welcome!",
      "Avantday website - https://www.avantday.io welcome!",
      "https://www.avantday.io/",
      &field_rev,
    );

    assert_url(
      &type_option,
      "Avantday website avantday.io welcome!",
      "Avantday website avantday.io welcome!",
      "https://avantday.io",
      &field_rev,
    );
  }

  /// if there's a http url and special words following it in the input string.
  #[test]
  fn url_type_option_contains_url_with_special_string_after_test() {
    let type_option = URLTypeOptionPB::default();
    let field_type = FieldType::URL;
    let field_rev = FieldBuilder::from_field_type(&field_type).build();
    assert_url(
      &type_option,
      "Avantday website - https://www.avantday.io!",
      "Avantday website - https://www.avantday.io!",
      "https://www.avantday.io/",
      &field_rev,
    );

    assert_url(
      &type_option,
      "Avantday website avantday.io!",
      "Avantday website avantday.io!",
      "https://avantday.io",
      &field_rev,
    );
  }

  /// if there's a level4 url in the input string.
  #[test]
  fn level4_url_type_test() {
    let type_option = URLTypeOptionPB::default();
    let field_type = FieldType::URL;
    let field_rev = FieldBuilder::from_field_type(&field_type).build();
    assert_url(
      &type_option,
      "test - https://tester.testgroup.avantday.io",
      "test - https://tester.testgroup.avantday.io",
      "https://tester.testgroup.avantday.io/",
      &field_rev,
    );

    assert_url(
      &type_option,
      "test tester.testgroup.avantday.io",
      "test tester.testgroup.avantday.io",
      "https://tester.testgroup.avantday.io",
      &field_rev,
    );
  }

  /// urls with different top level domains.
  #[test]
  fn different_top_level_domains_test() {
    let type_option = URLTypeOptionPB::default();
    let field_type = FieldType::URL;
    let field_rev = FieldBuilder::from_field_type(&field_type).build();
    assert_url(
      &type_option,
      "avantday - https://avantday.com",
      "avantday - https://avantday.com",
      "https://avantday.com/",
      &field_rev,
    );

    assert_url(
      &type_option,
      "avantday - https://avantday.top",
      "avantday - https://avantday.top",
      "https://avantday.top/",
      &field_rev,
    );

    assert_url(
      &type_option,
      "avantday - https://avantday.net",
      "avantday - https://avantday.net",
      "https://avantday.net/",
      &field_rev,
    );

    assert_url(
      &type_option,
      "avantday - https://avantday.edu",
      "avantday - https://avantday.edu",
      "https://avantday.edu/",
      &field_rev,
    );
  }

  fn assert_url(
    type_option: &URLTypeOptionPB,
    input_str: &str,
    expected_str: &str,
    expected_url: &str,
    _field_rev: &FieldRevision,
  ) {
    let decode_cell_data = type_option
      .apply_changeset(input_str.to_owned(), None)
      .unwrap()
      .1;
    assert_eq!(expected_str.to_owned(), decode_cell_data.content);
    assert_eq!(expected_url.to_owned(), decode_cell_data.url);
  }
}
