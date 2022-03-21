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
          {"id":9,"ranking":9,"name":"SQL"},
          {"id":20,"ranking":10,"name":"C++.net"},
          {"id":11,"ranking":11,"name":"Ruby"},
          {"id":12,"ranking":12,"name":"WordPress"},
          {"id":17,"ranking":13,"name":"Swift"},
          {"id":10,"ranking":14,"name":"Rails"},
          {"id":14,"ranking":15,"name":"Laravel"},
          {"id":13,"ranking":16,"name":"React"},
          {"id":18,"ranking":17,"name":"TypeScript"},
          {"id":15,"ranking":18,"name":"Django"},
          {"id":16,"ranking":19,"name":"Vue"},
          {"id":19,"ranking":20,"name":"Flutter"},
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















