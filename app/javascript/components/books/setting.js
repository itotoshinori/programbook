// 関数を定義します。
function func1() {
    const categories =
        [
          {"id":1,"ranking":1,"name":"HTML"},
          {"id":2,"ranking":2,"name":"C言語"},
          {"id":3,"ranking":3,"name":"C #.net"},
          {"id":4,"ranking":4,"name":"GO言語"},
          {"id":7,"ranking":5,"name":"Java"},
          {"id":8,"ranking":6,"name":"Python"},
          {"id":6,"ranking":7,"name":"PHP"},
          {"id":5,"ranking":8,"name":"JavaScript"},
          {"id":21,"ranking":9,"name":"機械学習"},
          {"id":9,"ranking":10,"name":"SQL"},
          {"id":20,"ranking":11,"name":"C++.net"},
          {"id":11,"ranking":12,"name":"Ruby"},
          {"id":12,"ranking":13,"name":"WordPress"},
          {"id":17,"ranking":14,"name":"Swift"},
          {"id":10,"ranking":15,"name":"Rails"},
          {"id":14,"ranking":16,"name":"Laravel"},
          {"id":13,"ranking":17,"name":"React"},
          {"id":18,"ranking":18,"name":"TypeScript"},
          {"id":23,"ranking":19,"name":"JavaSpring"},
          {"id":15,"ranking":20,"name":"Django"},
          {"id":16,"ranking":21,"name":"Vue"},
          {"id":22,"ranking":22,"name":"ReactNative"},
          {"id":19,"ranking":23,"name":"Flutter"},
        ]
    return categories
  }
  function func2() {
    const classificationcodes =
        [
            {"id":0,"name":""},
            {"id":1,"name":"本"},
            {"id":2,"name":"サイト"},
            {"id":3,"name":"動画"},
            {"id":4,"name":"その他"},
        ]
    return classificationcodes
  }
  
  
  
  // 関数をエクスポートします。
  export default {
    func1,
    func2
  };















